import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';

import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
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

  set projectName(String prjName) {
    _projectName = prjName;
  }

  Future<dynamic> fetchData({required RequestOptions requestOptions}) async {
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
    } on DioError catch (e) {
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

  Future<String> getClientCore() async {
    try {
      var response =
          await _dio.get('$_pageAPI/pages/layout/$_projectName/core');
      return Future.value(response.data["code"]);
    } on DioError catch (e) {
      log("Core not found => ${e.message}");
      return Future.value("");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getClientPageInfo(String pagePath) async {
    try {
      var response = await _dioCached
          .get('$_pageAPI/pages/layout/$_projectName/$pagePath');
      return Future.value(
        {
          "code": response.data["code"],
          "layout": response.data["layout"],
        },
      );
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw Exception(e.response?.data);
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ClientConfig> getClientConfig() async {
    var url = "";
    try {
      if (_beAPI!.contains("localhost")) {
        var uri = Uri.parse(_beAPI!);
        _beAPI = uri.replace(host: localhost).toString();
      }
      url = '$_beAPI/pages/client-config/$_projectName';
      final response = await _dio.get(url);
      final clientConfig = ClientConfig.fromJson(response.data);

      _pageAPI = clientConfig.pageAPI ?? _beAPI;
      if (_pageAPI!.contains("localhost")) {
        var uri = Uri.parse(_pageAPI!);
        _pageAPI = uri.replace(host: localhost).toString();
      }
      return clientConfig;
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data.toString());
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception("Cannot load '$_projectName' project config. URL: $url");
    }
  }

  Future<Map<String, dynamic>> getAppTheme({
    String? themePath = "theme",
  }) async {
    try {
      var response = await _dioCached
          .get('$_pageAPI/${themePath ?? "theme"}/$_projectName');
      return response.data;
    } on DioError catch (e) {
      log("Theme not found => ${e.message}");
      return {};
    } catch (e) {
      rethrow;
    }
  }

  // This help developing for ios because ios not allow load localhost in webview
  Future<Map<String, String>> getAppWebviewBundle() async {
    var app = _dioCached.get('http://localhost:8081/app.js');
    var vendors = _dioCached.get('http://localhost:8081/vendors.js');
    var bundle = await Future.wait([app, vendors]);
    return {
      "vendor": bundle[1].data,
      "app": bundle[0].data,
    };
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
