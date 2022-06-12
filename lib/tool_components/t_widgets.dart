import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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

class T_Widgets extends StatelessWidget {
  final Map<String, dynamic> layout;
  final String pagePath;
  UtilsManager utils = getIt<UtilsManager>();
  Map<String, dynamic> contextData;

  T_Widgets(
      {Key? key,
      required this.layout,
      required this.pagePath,
      required this.contextData})
      : super(key: key);

  Future<void> executeJSWithPagePath(String jsCode) async {
    await utils.evalJS.executeJS(jsCode, pagePath);
  }

  String? parseColor(String? rawColor) {
    if (rawColor != null && utils.isValueBinding(rawColor)) {
      return StyleUtils.getCssStringWithContextData(
        rawColor,
        contextData,
      );
    }
    return rawColor;
  }

  Widget _getWidget(Map<String, dynamic> contextData, BuildContext context) {
    Map<String, dynamic> content = layout["content"] ?? layout;

    var hidden = utils.bindingValueToProp(
      contextData,
      content["hidden"],
    );

    if (!UtilsManager.isFalsy(hidden)) {
      return const SizedBox.shrink();
    }

    var themeProvider = context.read<ThemeProvider>();
    Map<String, dynamic> widgetProps =
        themeProvider.mergeClasses(content, contextData);

    var finalWidgetProps = widgetProps;

    finalWidgetProps["color"] = parseColor(finalWidgetProps["color"]);
    finalWidgetProps["backgroundColor"] =
        parseColor(finalWidgetProps["backgroundColor"]);
    finalWidgetProps = themeProvider.mergeBaseColor(finalWidgetProps);
    // FIXME: xxxx
    finalWidgetProps = json.decode(
      json.encode(ThemeProvider.transformColorFromCSS(
        finalWidgetProps,
      )),
    );

    switch (gato.get(content, "type")) {
      case "text":
        return T_Text(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          contextData: contextData,
        );
      case "button":
        return T_Button(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          contextData: contextData,
        );
      case "icon":
        return T_Icon(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          contextData: contextData,
        );
      case "row":
        return T_Row(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          pageName: pagePath,
          contextData: contextData,
        );
      case "block":
        return T_Block(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          contextData: contextData,
        );
      case "container":
        return T_Container(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          pageName: pagePath,
          contextData: contextData,
        );
      case "column":
        return T_Column(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          pageName: pagePath,
          contextData: contextData,
        );
      case "scroll_view":
        return T_ScrollView(
          executeJS: executeJSWithPagePath,
          widgetProps: finalWidgetProps,
          pageName: pagePath,
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
    var contextData = context.watch<ContextStateProvider>().contextData;
    return _getWidget(contextData[pagePath] ?? {}, context);
  }
}
