import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/drawer_props/drawer_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TDrawer extends TWidget {
  TDrawer(TWidgetProps twidget) : super(twidget);

  @override
  State<TDrawer> createState() => _TDrawerState();
}

class _TDrawerState extends TStatefulWidget<TDrawer> {
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
          childData: const {},
        ),
      );
    }
    return _snapshot;
  }
}
