import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Container extends StatelessWidget {
  Map<String, dynamic> widgetProps;
  Future<void> Function(String js) executeJS;
  final String pageName;
  Map<String, dynamic> contextData;

  T_Container(
      {Key? key,
      required this.executeJS,
      required this.widgetProps,
      required this.pageName,
      required this.contextData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cssColor = widgetProps["backgroundColor"];
    Color? color = cssColor != null ? fromCssColor(cssColor) : null;

    return Container(
      color: color,
      child: T_Widgets(
        layout: widgetProps["child"] ?? {},
        pagePath: pageName,
        contextData: contextData,
      ),
    );
  }
}
