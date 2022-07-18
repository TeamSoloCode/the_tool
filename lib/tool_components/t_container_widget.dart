import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Container extends T_StateLessWidget {
  @override
  String pagePath;

  T_Container({
    Key? key,
    required executeJS,
    required widgetProps,
    required this.pagePath,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
          pagePath: pagePath,
        );

  @override
  Widget build(BuildContext context) {
    var props = widgetProps;
    var cssColor = props.backgroundColor;
    Color? color = cssColor != null ? fromCssColor(cssColor) : null;
    return Container(
      key: getBindingKey(),
      height: props.height,
      width: props.width,
      margin: ThemeDecoder.decodeEdgeInsetsGeometry(props.margin),
      constraints: BoxConstraints(
        maxHeight: props.maxHeight,
        maxWidth: props.maxWidth,
        minHeight: props.minHeight,
        minWidth: props.minWidth,
      ),
      color: color,
      child: T_Widgets(
        layout: widgetProps.child ?? const LayoutProps(),
        pagePath: pagePath,
        contextData: contextData,
      ),
    );
  }
}
