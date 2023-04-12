// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/foundation.dart';

class BaseConfig {
  BaseConfig() : super();

  final String MOBILE_WEBVIEW_URL = 'http://10.0.2.2:8081/';

  final String _localhost = "localhost";
  final String _beAPI = "http://localhost:3000";

  String get localhost {
    return kIsWeb ? _localhost : (Platform.isAndroid ? "10.0.2.2" : _localhost);
  }

  String get beAPI {
    return _beAPI;
  }
}
