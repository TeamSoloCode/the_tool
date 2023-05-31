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
  Future<Widget> _loadDrawerData() async {
    var drawerContent = TWidgets(
      layout: widget.props!,
      pagePath: widget.pagePath,
      childData: const {},
    );
    // await Future.delayed(const Duration(milliseconds: 800));
    return drawerContent;
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = widget.props;
    T_DrawerProps? _drawerProps = widget.drawerProps;

    var drawerWidth = widget.utils.computeSizeValue(
      _drawerProps?.width,
      widget.getContexData(),
    );

    if (_props != null) {
      widget.snapshot = Drawer(
        width: drawerWidth,
        child: FutureBuilder<Widget>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            }
            return const Offstage();
          },
          future: _loadDrawerData(),
        ),
      );
    }
    return widget.snapshot;
  }
}
