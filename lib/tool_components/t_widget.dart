import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/utils.dart';

abstract class T_Widget extends StatefulWidget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;
  Map<String, dynamic> contextData;
  final String? pageName;
  UtilsManager _utils = getIt<UtilsManager>();

  T_Widget({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
    required this.contextData,
    this.pageName,
  });

  Key? getBindingKey() {
    var rawKey = widgetProps["key"];
    if (rawKey == null) return null;
    if (UtilsManager.isValueBinding(rawKey)) {
      var bindingValue = _utils.bindingValueToText(contextData, rawKey);
      return Key(bindingValue);
    } else if (rawKey is String) {
      return Key(rawKey);
    }

    return null;
  }

  Future<void> setPageData(Map<String, dynamic> newData) async {
    await executeJS(
      "setPageData(JSON.parse('${json.encode(newData)}'));",
    );
  }
}
