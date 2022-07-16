import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_fields_widget.dart';
import 'package:the_tool/tool_components/fields/t_form_widget.dart';
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:the_tool/tool_components/t_component_widget.dart';
import 'package:the_tool/tool_components/t_expanded_widget.dart';
import 'package:the_tool/tool_components/t_grid_widget.dart';
import 'package:the_tool/tool_components/t_icon_widget.dart';
import 'package:the_tool/tool_components/t_row_widget.dart';
import 'package:the_tool/tool_components/t_scrollview_widget.dart';
import 'package:the_tool/tool_components/t_text_widget.dart';
import 'package:the_tool/utils.dart';

class T_Widgets extends StatefulWidget {
  final LayoutProps layout;
  final String pagePath;
  Map<String, dynamic> contextData;

  T_Widgets({
    Key? key,
    required this.layout,
    required this.pagePath,
    required this.contextData,
  }) : super(key: key);

  @override
  State<T_Widgets> createState() => _T_WidgetsState();
}

class _T_WidgetsState extends State<T_Widgets> {
  UtilsManager utils = getIt<UtilsManager>();

  Future<void> executeJSWithPagePath(String jsCode) async {
    await utils.evalJS?.executeJS(jsCode, widget.pagePath);
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
    LayoutProps content = widget.layout.content ?? widget.layout;

    var hidden = utils.bindingValueToProp(
      contextData,
      content.hidden,
    );

    if (!UtilsManager.isFalsy(hidden)) {
      return const SizedBox.shrink();
    }

    LayoutProps? widgetProps = _computeWidgetProps(
      content,
      contextData,
    );

    switch (content.type) {
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
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "form":
        return T_Form(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "component":
        return T_Component(
            executeJS: executeJSWithPagePath,
            widgetProps: widgetProps,
            contextData: contextData,
            pagePath: widget.pagePath);
      case "container":
        return T_Container(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "column":
        return T_Column(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "grid":
        return T_Grid(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "scroll_view":
        return T_ScrollView(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pagePath: widget.pagePath,
          contextData: contextData,
        );

      case "expanded":
        return T_Expanded(
          executeJS: executeJSWithPagePath,
          widgetProps: widgetProps,
          pagePath: widget.pagePath,
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

  LayoutProps? _computeWidgetProps(
    LayoutProps content,
    Map<String, dynamic> contextData,
  ) {
    var themeProvider = context.read<ThemeProvider>();
    LayoutProps? widgetProps =
        themeProvider.mergeClasses(content, contextData) ?? const LayoutProps();

    if (widgetProps.color != null) {
      widgetProps = widgetProps.copyWith(color: parseColor(widgetProps.color));
    }
    if (widgetProps.backgroundColor != null) {
      var backgroundColor = widgetProps.backgroundColor;
      var isBindingValue = UtilsManager.isValueBinding(backgroundColor);
      widgetProps = widgetProps.copyWith(
        backgroundColor: parseColor(
          isBindingValue
              ? utils.bindingValueToProp(
                  contextData,
                  backgroundColor,
                )
              : backgroundColor,
        ),
      );
    }

    widgetProps = themeProvider.mergeBaseColor(widgetProps);

    if (widgetProps.icon != null &&
        UtilsManager.isValueBinding(widgetProps.icon)) {
      widgetProps = widgetProps.copyWith(
        icon: utils.bindingValueToText(
          contextData,
          widgetProps.icon,
        ),
      );
    }

    if (widgetProps.text != null) {
      widgetProps = widgetProps.copyWith(
        text: utils.bindingValueToText(
          widget.contextData,
          widgetProps.text,
        ),
      );
    }

    if (widgetProps.componentProps != null) {
      Map<String, dynamic>? updatedComponentProps = {};
      widgetProps.componentProps?.forEach((key, value) {
        var isValueBinding = UtilsManager.isValueBinding(value);
        updatedComponentProps[key] = isValueBinding
            ? utils.bindingValueToProp(
                widget.contextData,
                value,
              )
            : value;
      });

      widgetProps = widgetProps.copyWith(componentProps: updatedComponentProps);
    }

    // FIXME: xxxx
    widgetProps = LayoutProps.fromJson(
      json.decode(
        json.encode(ThemeProvider.transformColorFromCSS(
          widgetProps.toJson(),
        )),
      ),
    );

    widgetProps = _computeHeightAndWidth(widgetProps);

    return widgetProps;
  }

  LayoutProps _computeHeightAndWidth(LayoutProps widgetProps) {
    double? heightResult;
    double? widthResult;

    dynamic maxHeight = widgetProps.maxHeight;
    dynamic maxWidth = widgetProps.maxWidth;
    dynamic minHeight = widgetProps.minHeight;
    dynamic minWidth = widgetProps.minWidth;

    dynamic height = widgetProps.height;
    dynamic width = widgetProps.width;

    double maxHeightResult = _computeValue(maxHeight) ?? double.infinity;
    double maxWidthResult = _computeValue(maxWidth) ?? double.infinity;
    double minHeightResult = _computeValue(minHeight) ?? 0.0;
    double minWidthResult = _computeValue(minWidth) ?? 0.0;

    heightResult = _computeValue(height);
    widthResult = _computeValue(width);

    assert(
      heightResult is num || heightResult == null,
      "\"height\" must be a number or bound with number value ($height)",
    );

    assert(
      widthResult is num || widthResult == null,
      "\"width\" must be a number or bound with number value ($width)",
    );

    return widgetProps.copyWith(
      height: heightResult,
      width: widthResult,
      maxHeight: maxHeightResult,
      maxWidth: maxWidthResult,
      minHeight: minHeightResult,
      minWidth: minWidthResult,
    );
  }

  dynamic _getBindingValue(String rawBind) {
    if (UtilsManager.isValueBinding(rawBind)) {
      return utils.bindingValueToProp(widget.contextData, rawBind);
    }
    return rawBind;
  }

  dynamic _computeValue(dynamic value) {
    if (value is String) {
      return _getBindingValue(value);
    } else if (value is num) {
      return value / 1.0;
    }
    return value;
  }
}
