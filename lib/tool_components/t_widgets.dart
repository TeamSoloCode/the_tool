import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';

class T_Widgets extends StatelessWidget {
  final Map<String, dynamic> layout;
  Future<void> Function(String js) executeJS;

  T_Widgets({
    Key? key,
    required this.layout,
    required this.executeJS,
  }) : super(key: key);

  Widget _getWidget() {
    Map<String, dynamic> content = layout["content"] ?? layout;

    switch (content["type"]) {
      case "button":
        return T_Button(
          executeJS: executeJS,
          widgetProps: content,
        );
      case "container":
        return T_Container(
          executeJS: executeJS,
          widgetProps: content,
        );
      case "column":
        return T_Column(executeJS: executeJS, widgetProps: content);
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return _getWidget();
  }
}
