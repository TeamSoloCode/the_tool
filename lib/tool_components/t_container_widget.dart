import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Container extends T_Widget {
  @override
  String pageName;

  T_Container({
    Key? key,
    required executeJS,
    required widgetProps,
    required this.pageName,
    required contextData,
  }) : super(
            key: key,
            widgetProps: widgetProps,
            executeJS: executeJS,
            contextData: contextData,
            pageName: pageName);

  @override
  State<T_Container> createState() => _T_ContainerState();
}

class _T_ContainerState extends State<T_Container> {
  @override
  Widget build(BuildContext context) {
    var cssColor = widget.widgetProps.backgroundColor;
    Color? color = cssColor != null ? fromCssColor(cssColor) : null;
    return Container(
      key: widget.getBindingKey(),
      color: color,
      child: T_Widgets(
        layout: widget.widgetProps.child ?? const LayoutProps(),
        pagePath: widget.pageName,
        contextData: widget.contextData,
      ),
    );
  }
}
