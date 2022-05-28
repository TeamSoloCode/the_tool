import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Column extends StatelessWidget {
  Map<String, dynamic> widgetProps;
  Future<void> Function(String js) executeJS;
  final String pageName;
  Map<String, dynamic> contextData;

  T_Column({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
    required this.contextData,
    required this.pageName,
  }) : super(key: key);

  List<Widget> _getChildren() {
    List<dynamic> children = widgetProps["children"];

    return children.map((child) {
      return T_Widgets(
        layout: child,
        pagePath: pageName,
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
