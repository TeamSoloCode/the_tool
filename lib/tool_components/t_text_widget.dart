import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class TText extends TStatelessWidget {
  TText(TWidgetProps twidget) : super(twidget);

  var text = "";

  @override
  Widget buildWidget(BuildContext context) {
    final textAlign = ThemeDecoder.decodeTextAlign(props?.textAlign);

    TextStyle? inlineStyle = ThemeDecoder.decodeTextStyle(props?.toJson());
    TextStyle? style = inlineStyle;
    final text = props?.text ?? "";

    if (props?.style != null && props?.style is String) {
      style = ThemeDecoder.decodeTextStyle(
        UtilsManager.get<Map<String, dynamic>>(
          themeProvider.themeDataAsJSON,
          props?.style,
        ),
      );
      style = style?.merge(inlineStyle);
    }

    if (props?.selectable == true) {
      snapshot = SelectableText(
        text,
        key: getBindingKey(),
        textAlign: textAlign,
        style: style,
      );
    } else {
      snapshot = Text(
        text,
        key: getBindingKey(),
        textAlign: textAlign,
        style: style,
      );
    }

    return snapshot;
  }
}
