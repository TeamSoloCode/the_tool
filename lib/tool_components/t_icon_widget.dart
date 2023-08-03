import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class T_Icon extends TStatelessWidget {
  T_Icon(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    if (props != null) {
      snapshot = Icon(
        MdiIcons.fromString(props!.icon ?? ""),
        key: getBindingKey(),
        color: ThemeDecoder.decodeColor(props!.color),
        size: props!.iconSize,
        weight: props!.weight,
      );
    }

    return snapshot;
  }
}
