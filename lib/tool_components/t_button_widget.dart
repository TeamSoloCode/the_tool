import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';

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
    String? text = context.select<ContextStateProvider, String?>(
        (state) => state.contextData["abcd"]?.toString());
    print("Re-render $text");
    return Container(
      margin: EdgeInsets.only(),
      child: TextButton(
        // child: Text(widgetProps["text"]),
        child: Text(
          text ?? "btn",
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
