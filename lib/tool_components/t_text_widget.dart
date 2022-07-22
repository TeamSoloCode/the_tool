import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_Text extends T_Widget {
  T_Text({
    Key? key,
    required executeJS,
    required widgetProps,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );
  @override
  State<T_Text> createState() => _T_TextState();
}

class _T_TextState extends State<T_Text> {
  var text = "";
  @override
  Widget build(BuildContext context) {
    LayoutProps? widgetProps = widget.widgetProps;
    if (kIsWeb) {
      return SelectableText(
        widgetProps.text ?? "",
        style: ThemeDecoder.decodeTextStyle(widgetProps.toJson()),
      );
    }

    return Text(
      widgetProps.text ?? "",
      style: ThemeDecoder.decodeTextStyle(widgetProps.toJson()),
    );
  }
}
