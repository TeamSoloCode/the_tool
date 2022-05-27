import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_Button extends T_Widget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;

  T_Button({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
        );

  @override
  Widget build(BuildContext context) {
    UtilsManager utils = getIt<UtilsManager>();
    var contextData = context.watch<ContextStateProvider>().contextData;

    return Container(
      margin: EdgeInsets.only(),
      child: TextButton(
        child: Text(
          utils.bindingValueToString(
            contextData,
            widgetProps["text"],
          ),
        ),
        onPressed: () async {
          var onClick = widgetProps["onClick"];
          if (onClick is String) {
            await executeJS(onClick);
          }
        },
      ),
    );
  }
}
