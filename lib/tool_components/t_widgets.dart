import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/tool_components/fields/t_input_widget.dart';
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/tool_components/t_block_widget.dart';
import 'package:the_tool/tool_components/t_icon_widget.dart';
import 'package:the_tool/tool_components/t_row_widget.dart';
import 'package:the_tool/tool_components/t_scrollview_widget.dart';
import 'package:the_tool/tool_components/t_text_widget.dart';
import 'package:the_tool/utils.dart';

class T_Widgets extends StatefulWidget {
  final Map<String, dynamic> layout;
  final String pagePath;
  Map<String, dynamic> contextData;

  T_Widgets(
      {Key? key,
      required this.layout,
      required this.pagePath,
      required this.contextData})
      : super(key: key);

  @override
  State<T_Widgets> createState() => _T_WidgetsState();
}

class _T_WidgetsState extends State<T_Widgets> {
  UtilsManager utils = getIt<UtilsManager>();

  Future<void> executeJSWithPagePath(String jsCode) async {
    await utils.evalJS.executeJS(jsCode, widget.pagePath);
  }

  String? parseColor(String? rawColor) {
    if (rawColor != null && UtilsManager.isValueBinding(rawColor)) {
      return StyleUtils.getCssStringWithContextData(
        rawColor,
        widget.contextData,
      );
    }
    return rawColor;
  }

  Widget _getWidget(Map<String, dynamic> contextData, BuildContext context) {
    Map<String, dynamic> content = widget.layout["content"] ?? widget.layout;

    var hidden = UtilsManager.bindingValueToProp(
      contextData,
      content["hidden"],
    );

    if (!UtilsManager.isFalsy(hidden)) {
      return const SizedBox.shrink();
    }

    Map<String, dynamic> widgetProps = _computeWidgetProps(
      content,
      contextData,
    );

    switch (gato.get(content, "type")) {
      case "text":
        return T_Text(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          contextData: contextData,
        );
      case "button":
        return T_Button(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          contextData: contextData,
        );
      case "icon":
        return T_Icon(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          contextData: contextData,
        );
      case "row":
        return T_Row(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pageName: widget.pagePath,
          contextData: contextData,
        );
      case "block":
        return T_Block(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          contextData: contextData,
        );
      case "container":
        return T_Container(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pageName: widget.pagePath,
          contextData: contextData,
        );
      case "column":
        return T_Column(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pageName: widget.pagePath,
          contextData: contextData,
        );
      case "scroll_view":
        return T_ScrollView(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pageName: widget.pagePath,
          contextData: contextData,
        );
      case "field":
        return T_Fields(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          contextData: contextData,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    var contextData = context.read<ContextStateProvider>().contextData;
    return _getWidget(contextData[widget.pagePath] ?? {}, context);
  }

  Map<String, dynamic> _computeWidgetProps(
    Map<String, dynamic> content,
    Map<String, dynamic> contextData,
  ) {
    var themeProvider = context.read<ThemeProvider>();
    Map<String, dynamic> widgetProps =
        themeProvider.mergeClasses(content, contextData);

    if (widgetProps["color"] != null) {
      widgetProps["color"] = parseColor(widgetProps["color"]);
    }
    if (widgetProps["backgroundColor"] != null) {
      widgetProps["backgroundColor"] =
          parseColor(widgetProps["backgroundColor"]);
    }
    widgetProps = themeProvider.mergeBaseColor(widgetProps);

    if (widgetProps["icon"] != null &&
        UtilsManager.isValueBinding(widgetProps["icon"])) {
      widgetProps["icon"] = UtilsManager.bindingValueToText(
        contextData,
        widgetProps["icon"],
      );
    }

    if (widgetProps["text"] != null) {
      widgetProps["text"] = UtilsManager.bindingValueToText(
        widget.contextData,
        gato.get(widgetProps, "text"),
      );
    }

    // FIXME: xxxx
    widgetProps = json.decode(
      json.encode(ThemeProvider.transformColorFromCSS(
        widgetProps,
      )),
    );

    return widgetProps;
  }
}
