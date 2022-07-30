import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_Text extends TStatelessWidget {
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
  Widget buildWidget(BuildContext context) {
    if (kIsWeb) {
      snapshot = SelectableText(
        props?.text ?? "",
        key: getBindingKey(),
        style: ThemeDecoder.decodeTextStyle(props?.toJson()),
      );
    } else {
      snapshot = Text(
        props?.text ?? "",
        key: getBindingKey(),
        style: ThemeDecoder.decodeTextStyle(props?.toJson()),
      );
    }

    return snapshot;
  }
}
