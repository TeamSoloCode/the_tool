import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';

class TTest extends StatelessWidget {
  Future<JsEvalResult> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;

  TTest({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text(widgetProps["text"]),
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
