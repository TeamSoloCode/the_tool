import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_Text extends T_StatelessWidget {
  T_Text({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  var text = "";

  @override
  Widget build(BuildContext context) {
    watchContextState(context);

    if (props?.hidden == true) {
      return const SizedBox.shrink();
    }

    prevProps = props;

    if (kIsWeb) {
      snapshot = SelectableText(
        props?.text ?? "",
        style: ThemeDecoder.decodeTextStyle(props?.toJson()),
      );
    } else {
      snapshot = Text(
        props?.text ?? "",
        style: ThemeDecoder.decodeTextStyle(props?.toJson()),
      );
    }

    return snapshot;
  }
}
