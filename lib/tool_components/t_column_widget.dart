import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Column extends T_StateLessWidget {
  final String pagePath;
  T_Column({
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
        );

  List<Widget> _getChildren() {
    List<LayoutProps> children = widgetProps.children ?? [];

    return children.map((child) {
      return T_Widgets(
        layout: child,
        pagePath: pagePath,
        contextData: contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getChildren(),
    );
  }
}
