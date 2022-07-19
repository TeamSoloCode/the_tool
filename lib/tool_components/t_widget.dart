import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';

abstract class T_Widget extends StatefulWidget {
  Future<void> Function(String js) executeJS;
  LayoutProps widgetProps;
  Map<String, dynamic> contextData;
  final String? pagePath;
  UtilsManager _utils = getIt<UtilsManager>();

  T_Widget({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
    required this.contextData,
    this.pagePath,
  });

  ValueKey? getBindingKey() {
    var rawKey = widgetProps.key;
    if (rawKey == null) return null;
    if (UtilsManager.isValueBinding(rawKey)) {
      var bindingValue = _utils.bindingValueToText(contextData, rawKey);
      return ValueKey(bindingValue);
    }

    return ValueKey(rawKey);
  }

  Future<void> setPageData(Map<String, dynamic> newData) async {
    await executeJS(
      "setPageData(JSON.parse('${json.encode(newData)}'));",
    );
  }
}
