import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:gato/gato.dart' as gato;

abstract class T_Widget extends StatefulWidget {
  LayoutProps widgetProps;
  Map<String, dynamic> parentData;
  final String pagePath;
  UtilsManager utils = getIt<UtilsManager>();
  final String? widgetUuid;

  LayoutProps? props;
  LayoutProps? prevProps;
  Widget snapshot = const SizedBox.shrink();
  Map<String, dynamic> contextData = {};
  final Set<String> widgetBindingStrings = {};
  List<dynamic> prevBindingValues = [];
  var hasBindingValue = false;

  T_Widget({
    Key? key,
    required this.widgetProps,
    required this.parentData,
    required this.pagePath,
    required this.widgetUuid,
  }) : super(key: key) {
    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
      );
    }
  }

  void watchContextState(BuildContext context) {
    var prevData = contextData;
    context.select((ContextStateProvider value) {
      var newPageData = value.contextData[pagePath] ?? {"": null};
      if (!hasBindingValue || !isTWidgetDependenciesChanged(newPageData)) {
        return prevData;
      }
      contextData = newPageData;
      return newPageData;
    });

    if (prevProps != null && !hasBindingValue) {
      return;
    }

    props = utils.computeWidgetProps(
      widgetProps,
      contextData,
    );

    prevProps = props;

    debugPrint(
        "rebuild widget ${widgetProps.type} ${widgetBindingStrings} ${Timeline.now}");
  }

  void updateWidgetBindingStrings(String bindingString) {
    widgetBindingStrings.add(bindingString);
  }

  bool isTWidgetDependenciesChanged(Map<String, dynamic> contextData) {
    var newBindingValues = widgetBindingStrings.map((widgetBindingString) {
      return gato.get(contextData, widgetBindingString).toString();
    }).toList();

    var isChanged = !const DeepCollectionEquality().equals(
      newBindingValues,
      prevBindingValues,
    );

    if (isChanged) {
      prevBindingValues = newBindingValues;
    }

    return isChanged;
  }

  Future<dynamic> executeJSWithPagePath(String jsCode) async {
    return await utils.evalJS?.executeJS(jsCode, pagePath);
  }

  Key? getBindingKey() {
    var rawKey = widgetProps.key;
    if (rawKey == null) return key;
    if (UtilsManager.isValueBinding(rawKey)) {
      var bindingValue = utils.bindingValueToText(parentData, rawKey);
      return ValueKey(bindingValue);
    }

    return ValueKey(rawKey);
  }

  Future<void> setPageData(Map<String, dynamic> newData) async {
    await executeJSWithPagePath(
      "setPageData(JSON.parse('${json.encode(newData)}'));",
    );
  }
}

abstract class T_StatelessWidget extends StatelessWidget {
  final LayoutProps widgetProps;
  final Map<String, dynamic> parentData;
  final String pagePath;
  final UtilsManager utils = getIt<UtilsManager>();
  final String? widgetUuid;

  LayoutProps? props;
  LayoutProps? prevProps;
  Widget snapshot = const SizedBox.shrink();
  Map<String, dynamic> contextData = {};
  final Set<String> widgetBindingStrings = {};
  List<String> prevBindingValues = [];
  var hasBindingValue = false;

  T_StatelessWidget({
    Key? key,
    required this.widgetProps,
    required this.parentData,
    required this.pagePath,
    required this.widgetUuid,
  }) : super(key: key) {
    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
      );
    }
  }

  void watchContextState(BuildContext context) {
    var prevData = contextData;
    context.select((ContextStateProvider value) {
      var newPageData = value.contextData[pagePath] ?? {"": null};
      if (!hasBindingValue || !isTWidgetDependenciesChanged(newPageData)) {
        return prevData;
      }

      contextData = newPageData;
      return newPageData;
    });

    if (prevProps != null && !hasBindingValue) {
      return;
    }

    props = utils.computeWidgetProps(
      widgetProps,
      contextData,
    );

    prevProps = props;

    debugPrint(
        "rebuild widget ${widgetProps.type} ${widgetBindingStrings} ${Timeline.now}");
  }

  void updateWidgetBindingStrings(String bindingString) {
    widgetBindingStrings.add(bindingString);
  }

  bool isTWidgetDependenciesChanged(Map<String, dynamic> contextData) {
    var newBindingValues = widgetBindingStrings.map((widgetBindingString) {
      return gato.get(contextData, widgetBindingString).toString();
    }).toList();

    var isChanged = !const DeepCollectionEquality().equals(
      newBindingValues,
      prevBindingValues,
    );

    if (isChanged) {
      prevBindingValues = newBindingValues;
    }

    return isChanged;
  }

  Future<void> executeJSWithPagePath(String jsCode) async {
    await utils.evalJS?.executeJS(jsCode, pagePath);
  }

  Key? getBindingKey() {
    var rawKey = widgetProps.key;
    if (rawKey == null) return key;
    if (UtilsManager.isValueBinding(rawKey)) {
      var bindingValue = utils.bindingValueToText(parentData, rawKey);
      return ValueKey(bindingValue);
    }

    return ValueKey(rawKey);
  }

  Future<void> setPageData(Map<String, dynamic> newData) async {
    await executeJSWithPagePath(
      "setPageData(JSON.parse('${json.encode(newData)}'));",
    );
  }
}
