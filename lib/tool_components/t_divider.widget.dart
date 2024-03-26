import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TDivider extends TStatelessWidget {
  TDivider(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = props;

    if (_props != null) {
      snapshot = Divider(
        key: getBindingKey(),
        color: ThemeDecoder.decodeColor(_props.color),
        height: props?.height,
        thickness: props?.thickness,
        endIndent: props?.endIndent,
        indent: props?.indent,
      );
    }

    return snapshot;
  }
}
