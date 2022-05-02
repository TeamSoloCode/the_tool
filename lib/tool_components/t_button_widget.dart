import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/utils.dart';

class T_Button extends StatelessWidget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;
  Map<String, dynamic> contextData;

  T_Button({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
    required this.contextData,
  }) : super(key: key);

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
