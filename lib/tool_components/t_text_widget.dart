import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

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
  var oldText = "";
  var text = "";

  LayoutProps? prevWidgetProps;
  LayoutProps? finalWidgetProps;

  bool shouldWidgetUpdate() {
    finalWidgetProps = widget.widgetProps;

    var shouldUpdate = !const DeepCollectionEquality().equals(
      prevWidgetProps,
      finalWidgetProps,
    );

    return shouldUpdate;
  }

  @override
  Widget build(BuildContext context) {
    return ShouldWidgetUpdate(
      key: widget.getBindingKey(),
      builder: (context) {
        prevWidgetProps = finalWidgetProps;

        assert(
          shouldWidgetUpdate() == false,
          "shouldWidgetUpdate should be false after build new project",
        );

        if (kIsWeb) {
          return SelectableText(
            finalWidgetProps?.text ?? "",
            style: ThemeDecoder.decodeTextStyle(finalWidgetProps?.toJson()),
          );
        }

        return Text(
          finalWidgetProps?.text ?? "",
          style: ThemeDecoder.decodeTextStyle(finalWidgetProps?.toJson()),
        );
      },
      shouldWidgetUpdate: shouldWidgetUpdate(),
    );
  }
}
