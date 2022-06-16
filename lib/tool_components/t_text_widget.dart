import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/utils.dart';

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

  Map<String, dynamic> prevFinalWidgetProps = {};
  Map<String, dynamic> finalWidgetProps = {};

  bool shouldWidgetUpdate() {
    UtilsManager utils = getIt<UtilsManager>();

    finalWidgetProps = widget.widgetProps;

    text = utils.bindingValueToText(
      widget.contextData,
      gato.get(finalWidgetProps, "text"),
    );

    var shouldUpdate = text != oldText ||
        !mapEquals(
          prevFinalWidgetProps,
          finalWidgetProps,
        );

    if (shouldUpdate) {
      log("ShouldWidgetUpdate $oldText => $text ${!mapEquals(
        prevFinalWidgetProps,
        finalWidgetProps,
      )}, $prevFinalWidgetProps $finalWidgetProps");
    }

    return shouldUpdate;
  }

  @override
  Widget build(BuildContext context) {
    return ShouldWidgetUpdate(
      builder: (context) {
        oldText = text;
        prevFinalWidgetProps = finalWidgetProps;

        return Text(
          text,
          style: ThemeDecoder.decodeTextStyle(finalWidgetProps),
        );
      },
      shouldWidgetUpdate: shouldWidgetUpdate(),
    );
  }
}
