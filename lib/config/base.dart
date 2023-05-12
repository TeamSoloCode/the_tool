// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/foundation.dart';

class BaseConfig {
  bool isProduction;

  BaseConfig({required this.isProduction}) : super();

  final String _MOBILE_WEBVIEW_URL = 'http://localhost:8081/';

  final String _localhost = "localhost";
  final String _beAPI = "http://localhost:3000";

  String get MOBILE_WEBVIEW_URL {
    return kIsWeb ? _MOBILE_WEBVIEW_URL : (Platform.isAndroid ? "http://10.0.2.2:8081/" : _MOBILE_WEBVIEW_URL);
  }

  String get localhost {
    return kIsWeb ? _localhost : (Platform.isAndroid ? "10.0.2.2" : _localhost);
  }

  String get beAPI {
    return _beAPI;
  }
}
