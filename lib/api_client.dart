import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIClientManager {
  final String host = kIsWeb ? "localhost" : "10.0.2.2";

  const APIClientManager();

  Future<dynamic> fetchData({required String path}) async {
    if (path.contains("localhost")) {
      path = path.replaceFirst("localhost", host);
    }

    RequestOptions requestOptions = RequestOptions(
      path: path,
    );

    var response = await Dio().fetch(requestOptions);

    return {
      "data": response.data,
      "headers": json.encode(response.headers.map),
      "statusCode": response.statusCode,
      "statusMessage": response.statusMessage,
      "isRedirect": response.isRedirect,
      "extra": response.extra
    };
  }

  Future<String> getClientCore() async {
    try {
      var response = await Dio().get('http://$host:3000/pages/core');
      return Future.value(response.data["code"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getClientPageInfo(String pagePath) async {
    try {
      var response = await Dio().get('http://$host:3000/pages/$pagePath');
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
            {"name": "Test Page", "path": "test_page"}
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
      rethrow;
    }
  }
}
