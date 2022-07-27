import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Container extends T_StatelessWidget {
  T_Container({
    Key? key,
    required widgetProps,
    required pagePath,
    required contextData,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  Widget build(BuildContext context) {
    watchContextState(context);

    if (props?.hidden == true) {
      return const SizedBox.shrink();
    }

    var cssColor = props?.backgroundColor;
    Color? color = cssColor != null ? fromCssColor(cssColor) : null;

    snapshot = RepaintBoundary(
      child: Container(
        key: getBindingKey(),
        height: props?.height,
        width: props?.width,
        margin: ThemeDecoder.decodeEdgeInsetsGeometry(props?.margin),
        constraints: BoxConstraints(
          maxHeight: props?.maxHeight,
          maxWidth: props?.maxWidth,
          minHeight: props?.minHeight,
          minWidth: props?.minWidth,
        ),
        color: color,
        child: T_Widgets(
          layout: props?.child ?? const LayoutProps(),
          pagePath: pagePath,
          contextData: contextData,
        ),
      ),
    );

    return snapshot;
  }
}
