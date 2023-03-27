import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:gato/gato.dart' as gato;

class T_Text extends TStatelessWidget {
  T_Text(TWidgetProps twidget) : super(twidget);

  var text = "";

  @override
  Widget buildWidget(BuildContext context) {
    final textAlign = ThemeDecoder.decodeTextAlign(props?.textAlign);

    TextStyle? inlineStyle = ThemeDecoder.decodeTextStyle(props?.toJson());
    TextStyle? style = inlineStyle;

    if (props?.style != null && props?.style is String) {
      style = ThemeDecoder.decodeTextStyle(
        gato.get<Map<String, dynamic>>(
          themeProvider.themeDataAsJSON,
          props?.style,
        ),
      );

      style?.merge(inlineStyle);
    }

    if (props?.selectable == true) {
      snapshot = SelectableText(
        props?.text ?? "",
        key: getBindingKey(),
        textAlign: textAlign,
        style: style,
      );
    } else {
      snapshot = Text(
        props?.text ?? "",
        key: getBindingKey(),
        textAlign: textAlign,
        style: style,
      );
    }

    return snapshot;
  }
}
