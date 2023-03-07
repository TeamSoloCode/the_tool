import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class T_Icon extends TWidget {
  T_Icon(TWidgetProps twidget) : super(twidget);

  @override
  State<T_Icon> createState() => _T_IconState();
}

class _T_IconState extends TStatefulWidget<T_Icon> {
  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      var path = _props.icon ?? "";
      _snapshot = Icon(MdiIcons.fromString(path));
    }

    return _snapshot;
  }
}
