import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Drawer extends TWidget {
  T_Drawer({
    Key? key,
    required widgetUuid,
    required widgetProps,
    required pagePath,
    childData = const {},
  }) : super(
          key: key,
          childData: childData,
          widgetUuid: widgetUuid,
          pagePath: pagePath,
          widgetProps: widgetProps,
        );

  @override
  State<T_Drawer> createState() => _T_DrawerState();
}

class _T_DrawerState extends TStatefulWidget<T_Drawer> {
  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = Drawer(
        child: TWidgets(
          layout: _props,
          pagePath: widget.pagePath,
        ),
      );
    }
    return _snapshot;
  }
}
