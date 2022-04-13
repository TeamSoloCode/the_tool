import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Container extends StatelessWidget {
  Map<String, dynamic> widgetProps;
  Future<JsEvalResult> Function(String js) executeJS;

  T_Container({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fromCssColor(widgetProps["backgroundColor"]),
      child: T_Widgets(
        layout: widgetProps["child"] ?? {},
        executeJS: executeJS,
      ),
    );
  }
}
