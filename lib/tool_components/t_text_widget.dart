import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_Text extends TStatelessWidget {
  T_Text(TWidgetProps twidget) : super(twidget);

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
