import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/tool_components/t_text_widget.dart';
import 'package:the_tool/utils.dart';

class T_Widgets extends StatelessWidget {
  final Map<String, dynamic> layout;
  Map<String, dynamic> contextData = {};

  T_Widgets({
    Key? key,
    required this.layout,
    this.contextData = const {},
  }) : super(key: key);

  Widget _getWidget() {
    UtilsManager utils = getIt<UtilsManager>();
    Map<String, dynamic> content = layout["content"] ?? layout;

    switch (gato.get(content, "type")) {
      case "text":
        return T_Text(
          executeJS: utils.evalJS.executeJS,
          widgetProps: content,
          contextData: contextData,
        );
      case "button":
        return T_Button(
          executeJS: utils.evalJS.executeJS,
          widgetProps: content,
          contextData: contextData,
        );
      case "container":
        return T_Container(
          executeJS: utils.evalJS.executeJS,
          widgetProps: content,
        );
      case "column":
        return T_Column(
          executeJS: utils.evalJS.executeJS,
          widgetProps: content,
        );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return _getWidget();
  }
}
