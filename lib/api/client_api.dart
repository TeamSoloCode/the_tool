import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';

import 'package:the_tool/utils.dart';

class APIClientManager {
  final _envConfig = getIt<EnvironmentConfig>();
  late final String localhost;
  final Dio _dio = Dio();
  final _dioCached = Dio();

  late String? _beAPI = _envConfig.beAPI;
  String? _pageAPI;

  String _projectName =
      getIt<StorageManager>().getLocalBox("projectName") ?? "";

  APIClientManager() : super() {
    localhost = _envConfig.localhost;
    _beAPI = _envConfig.beAPI;

    var prettyDioLogger = PrettyDioLogger(
      logPrint: (object) {
        log("$object");
      },
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );

    _dio.interceptors.add(prettyDioLogger);
    _dioCached.interceptors.add(prettyDioLogger);
    _dioCached.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['x-platform'] = kIsWeb ? "web" : "mobile";
        return handler.next(options);
      },
    ));

    var cacheStore = MemCacheStore();
    var cacheOptions = CacheOptions(
      store: cacheStore,
      maxStale: const Duration(seconds: 30),
      hitCacheOnErrorExcept: [],
      policy: CachePolicy.forceCache,
    );

    _dioCached.interceptors.add(
      DioCacheInterceptor(options: cacheOptions),
    );
  }

  String? get projectName => getIt<StorageManager>().getProjectName();

  Future<dynamic> tRequest({required RequestOptions requestOptions}) async {
    try {
      String path = requestOptions.path;

      if (path.contains("localhost")) {
        path = path.replaceFirst("localhost", localhost);
      }

      var response = await _dio.request(
        path,
        options: Options(
          method: requestOptions.method,
        ),
        data: requestOptions.data,
      );

      return {
        "data": response.data,
        "headers": json.encode(response.headers.map),
        "statusCode": response.statusCode,
        "statusMessage": response.statusMessage,
        "isRedirect": response.isRedirect,
        "extra": response.extra
      };
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return {"err": true, "response": e.response?.data};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return {
          "err": true,
          "message": e.message,
          "response": {"error": "Fail to fetch"}
        };
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response<Map<String, dynamic>>> postImageFormData(
    FormData formData, {
    Map<String, dynamic> options = const {},
  }) {
    var uploadFileHost = options["host"] ??
        getIt<ContextStateProvider>().appConfig?.uploadFileHost;
    String endpoint = "";

    if (uploadFileHost == null) {
      throw Exception(
          "Please configure \"uploadFileHost\" in client configuration.");
    }

    if (uploadFileHost.startsWith("http")) {
      endpoint = uploadFileHost;
    } else if (uploadFileHost.startsWith("/")) {
      endpoint = "$_beAPI$uploadFileHost";
    } else {
      endpoint = "$_beAPI/$uploadFileHost";
    }

    return _dio.post(endpoint, data: formData);
  }
}
