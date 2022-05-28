import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/tool_components/t_text_widget.dart';
import 'package:the_tool/utils.dart';

class T_Widgets extends StatelessWidget {
  final Map<String, dynamic> layout;
  final String pagePath;
  UtilsManager utils = getIt<UtilsManager>();
  Map<String, dynamic> contextData;

  T_Widgets(
      {Key? key,
      required this.layout,
      required this.pagePath,
      required this.contextData})
      : super(key: key);

  Future<void> executeJSWithPagePath(String jsCode) async {
    await utils.evalJS.executeJS(jsCode, pagePath);
  }

  Widget _getWidget(Map<String, dynamic> contextData) {
    Map<String, dynamic> content = layout["content"] ?? layout;

    switch (gato.get(content, "type")) {
      case "text":
        return T_Text(
          executeJS: executeJSWithPagePath,
          widgetProps: content,
          contextData: contextData,
        );
      case "button":
        return T_Button(
          executeJS: executeJSWithPagePath,
          widgetProps: content,
          contextData: contextData,
        );
      case "container":
        return T_Container(
          executeJS: executeJSWithPagePath,
          widgetProps: content,
          pageName: pagePath,
          contextData: contextData,
        );
      case "column":
        return T_Column(
          executeJS: executeJSWithPagePath,
          widgetProps: content,
          pageName: pagePath,
          contextData: contextData,
        );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    var contextData = context.watch<ContextStateProvider>().contextData;
    return _getWidget(contextData[pagePath] ?? {});
  }
}
