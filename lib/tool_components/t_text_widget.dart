import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/utils.dart';

class T_Text extends T_Widget {
  Future<void> Function(String js) executeJS;
  Map<String, dynamic> widgetProps;
  Map<String, dynamic> contextData;

  T_Text({
    Key? key,
    required this.executeJS,
    required this.widgetProps,
    required this.contextData,
  }) : super(
          key: key,
          contextData: contextData,
          widgetProps: widgetProps,
          executeJS: executeJS,
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
