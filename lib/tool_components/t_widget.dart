import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/utils.dart';

abstract class T_Widget extends StatefulWidget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;
  Map<String, dynamic> contextData;
  final String? pageName;

  T_Widget(
      {Key? key,
      required this.executeJS,
      required this.widgetProps,
      required this.contextData,
      this.pageName});

  Key? getBindingKey() {
    var rawKey = widgetProps["key"];
    if (rawKey == null) return null;
    if (UtilsManager.isValueBinding(rawKey)) {
      var bindingValue = UtilsManager.bindingValueToText(contextData, rawKey);
      return Key(bindingValue);
    } else if (rawKey is String) {
      return Key(rawKey);
    }

    return null;
  }

  void setPageData(Map<String, dynamic> newData) {
    executeJS(
      "setPageData(JSON.parse('${json.encode(newData)}'));",
    );
  }
}
