import 'package:flutter/material.dart';

class T_Button extends StatelessWidget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;

  T_Button({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(widgetProps["text"]),
      onPressed: () async {
        var onClick = widgetProps["onClick"];
        if (onClick is String) {
          await executeJS(onClick);
        }
      },
    );
  }
}
