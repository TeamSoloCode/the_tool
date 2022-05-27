import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/utils.dart';

class T_Text extends StatelessWidget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;

  T_Text({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    UtilsManager utils = getIt<UtilsManager>();
    var contextData = context.watch<ContextStateProvider>().contextData;
    String text = gato.get(widgetProps, "text") ?? "";
    return Text(
      utils.bindingValueToString(contextData, text),
    );
  }
}
