import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/drawer_props/drawer_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/common_interfaces.dart';

class T_Drawer extends TWidget {
  T_Drawer(TWidgetProps twidget) : super(twidget);

  @override
  State<T_Drawer> createState() => _T_DrawerState();
}

class _T_DrawerState extends TStatefulWidget<T_Drawer> {
  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;
    T_DrawerProps? _drawerProps = widget.drawerProps;

    var drawerWidth = widget.utils.computeSizeValue(
      _drawerProps?.width,
      widget.getContexData(),
    );

    if (_props != null) {
      _snapshot = Drawer(
        width: drawerWidth,
        child: TWidgets(
          layout: _props,
          pagePath: widget.pagePath,
        ),
      );
    }
    return _snapshot;
  }
}
