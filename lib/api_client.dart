import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:the_tool/page_utils/storage_manager.dart';

import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/utils.dart';

class APIClientManager {
  final String host =
      kIsWeb ? "localhost" : (Platform.isAndroid ? "10.0.2.2" : "localhost");
  String _projectName =
      getIt<StorageManager>().getLocalBox("projectName") ?? "";
  final Dio _dio = Dio();

  final _dioCached = Dio();

  APIClientManager() : super() {
    _dio.interceptors.add(PrettyDioLogger(
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

  set projectName(String prjName) {
    _projectName = prjName;
  }

  String? _beAPI = "http://localhost:3000";
  String? _pageAPI;

  Future<dynamic> fetchData({required RequestOptions requestOptions}) async {
    try {
      String path = requestOptions.path;

      if (path.contains("localhost")) {
        path = path.replaceFirst("localhost", host);
      }

      var response = await _dio.request(
        path,
        options: Options(method: requestOptions.method),
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
    }
  }

  Future<String> getClientCore() async {
    try {
      var response =
          await _dio.get('$_pageAPI/pages/layout/$_projectName/core');
      return Future.value(response.data["code"]);
    } on DioError catch (e) {
      log("Core not found => " + e.message);
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
        _beAPI = uri.replace(host: host).toString();
      }
      url = '$_beAPI/pages/client-config/$_projectName';
      final response = await _dio.get(url);
      final clientConfig = ClientConfig.fromJson(json.decode(response.data));

      _pageAPI = clientConfig.pageAPI ?? _beAPI;
      if (_pageAPI!.contains("localhost")) {
        var uri = Uri.parse(_pageAPI!);
        _pageAPI = uri.replace(host: host).toString();
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
      return Future.value(response.data);
    } on DioError catch (e) {
      log("Theme not found => " + e.message);
      return Future.value({});
    } catch (e) {
      rethrow;
    }
  }
}
