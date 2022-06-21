import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIClientManager {
  final String host = kIsWeb ? "localhost" : "10.0.2.2";
  final Dio _dio = Dio();

  APIClientManager() : super() {
    // _dio.interceptors.add(PrettyDioLogger(
    //   logPrint: (object) {
    //     log("$object");
    //   },
    //   requestHeader: false,
    //   requestBody: false,
    //   responseBody: false,
    //   responseHeader: false,
    //   error: true,
    //   compact: true,
    //   maxWidth: 90,
    // ));
  }

  Future<dynamic> fetchData({required RequestOptions requestOptions}) async {
    try {
      String path = requestOptions.path;

      if (path.contains("localhost")) {
        path = path.replaceFirst("localhost", host);
      }

      var response = await _dio.fetch(requestOptions.copyWith(path: path));

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
      var response = await _dio.get('http://$host:3000/pages/core');
      return Future.value(response.data["code"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getClientPageInfo(String pagePath) async {
    try {
      var response = await _dio.get('http://$host:3000/pages/$pagePath');
      return Future.value(
        {
          "code": response.data["code"],
          "layout": response.data["layout"],
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getClientConfig() async {
    try {
      return Future.value(
        {
          "initialPage": "init_page",
          "routes": [
            {"name": "Home Page", "path": "home_page"},
            {"name": "Fields Page", "path": "fields_page"},
            {"name": "Test Page", "path": "test_page"},
            {"name": "Test API", "path": "test_api"}
          ]
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAppTheme() async {
    try {
      return Future.value(
        {
          "base": {
            "#primaryColor": "green",
            "#primaryWatchColor": "skyblue",
            "--dark": {
              "#primaryColor": "purple",
              "#primaryWatchColor": "black",
            },
          },
          "theme": {
            "primaryColor": "#primaryColor",
            "scaffoldBackgroundColor": "#primaryColor",
            "primarySwatch": "#primaryWatchColor",
            "textTheme": {
              "bodyText2": {
                "color": "#primaryWatchColor",
                "fontSize": 15,
                "fontWeight": "bold"
              }
            },
            "appBarTheme": {
              "backgroundColor": "#primaryWatchColor",
              "shape": {
                "type": "rounded",
                "borderRadius": {
                  "type": "vertical",
                  "bottom": {"type": "circular", "radius": 25}
                },
              },
            }
          },
          "classes": {
            "text-error": {"color": "red"},
            "text-error--small": {"color": "violet", "fontSize": 17}
          }
        },
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
