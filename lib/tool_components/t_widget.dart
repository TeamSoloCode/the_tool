import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:gato/gato.dart' as gato;

mixin BaseStateWidget on Widget {
  late final LayoutProps widgetProps;
  late final Map<String, dynamic> parentData;
  late final String pagePath;
  final UtilsManager utils = getIt<UtilsManager>();
  final contextStateProvider = getIt<ContextStateProvider>();
  late final String? widgetUuid;

  LayoutProps? props;
  LayoutProps? prevProps;
  Widget snapshot = const SizedBox.shrink();
  Map<String, dynamic> contextData = {};
  final Set<String> widgetBindingStrings = {};
  List<dynamic> prevBindingValues = [];
  var hasBindingValue = false;

  void watchContextState(BuildContext context, {String? providedPagePath}) {
    var prevData = contextData;
    var path = providedPagePath ?? pagePath;
    context.select((ContextStateProvider value) {
      var newPageData = value.contextData[path] ?? {"": null};
      if (!hasBindingValue ||
          !isTWidgetDependenciesChanged(
            newPageData,
            providedPagePath: path,
          )) {
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

    debugPrint("rebuild widget ${widgetProps.type} ${Timeline.now}");

    return;
  }

  void updateWidgetBindingStrings(String bindingString) {
    widgetBindingStrings.add(bindingString);
  }

  bool isTWidgetDependenciesChanged(
    Map<String, dynamic> contextData, {
    String? providedPagePath,
  }) {
    var depsAsString =
        "${providedPagePath ?? pagePath}_${widgetBindingStrings.toString()}";
    var caheValue =
        contextStateProvider.cacheCheckTWidgetDepsChanged[depsAsString];

    if (caheValue != null) {
      return caheValue;
    }

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

    // Cache the result for later use
    contextStateProvider.updateCacheCheckTWidgetDepsChanged(
      depsAsString,
      isChanged,
    );
    debugPrint(
        "isTWidgetDependenciesChanged ${widgetProps.type} ${widgetBindingStrings.toString()} ${isChanged}");
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

abstract class T_Widget extends StatefulWidget with BaseStateWidget {
  T_Widget({
    Key? key,
    required widgetProps,
    required parentData,
    required pagePath,
    required widgetUuid,
  }) : super(key: key) {
    this.widgetProps = widgetProps;
    this.parentData = parentData;
    this.pagePath = pagePath;
    this.widgetUuid = widgetUuid;
    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
      );
    }
  }
}

abstract class T_StatelessWidget extends StatelessWidget with BaseStateWidget {
  T_StatelessWidget({
    Key? key,
    required widgetProps,
    required parentData,
    required pagePath,
    required widgetUuid,
  }) : super(key: key) {
    this.widgetProps = widgetProps;
    this.parentData = parentData;
    this.pagePath = pagePath;
    this.widgetUuid = widgetUuid;
    if (prevProps == null) {
      hasBindingValue = utils.hasBindingValue(
        widgetProps,
        updateWidgetBindingStrings,
      );
    }
  }
}
