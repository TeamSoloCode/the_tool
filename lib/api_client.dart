import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIClientManager {
  final String host = kIsWeb ? "localhost" : "10.0.2.2";

  const APIClientManager();

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
          "initialPage": "test_page",
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
}
