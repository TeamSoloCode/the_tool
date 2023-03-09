import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class T_Icon extends TStatelessWidget {
  T_Icon(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = snapshot;
    LayoutProps? _props = props;

    if (_props != null) {
      var path = _props.icon ?? "";
      _snapshot = Icon(
        MdiIcons.fromString(path),
        key: getBindingKey(),
        color: ThemeDecoder.decodeColor(_props.color),
        size: _props.iconSize,
        weight: _props.weight,
      );
    }

    return _snapshot;
  }
}
