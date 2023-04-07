// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/foundation.dart';

class BaseConfig {
  BaseConfig() : super();

  final String MOBILE_WEBVIEW_URL = 'http://10.0.2.2:8081/';

  String _localhost = "localhost";

  String get localhost {
    return kIsWeb ? _localhost : (Platform.isAndroid ? "10.0.2.2" : _localhost);
  }
}
