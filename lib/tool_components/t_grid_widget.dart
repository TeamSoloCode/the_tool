import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Grid extends TWidget {
  T_Grid({
    Key? key,
    required widgetProps,
    required pagePath,
    childData = const {},
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          childData: childData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_Grid> createState() => _T_GridState();
}

class _T_GridState extends TStatefulWidget<T_Grid> {
  List<Widget> _items = [];

  List<Widget> _computeChildren(List<dynamic>? children) {
    return (children ?? []).map((child) {
      return TWidgets(
        layout: child,
        pagePath: widget.pagePath,
        childData: widget.childData,
      );
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _items = _computeChildren(_props.children);
      _snapshot = GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width,
          mainAxisExtent: 200,
        ),
        itemCount: _items.length,
        itemBuilder: (BuildContext ctx, index) {
          return _items.elementAt(index);
        },
      );
    }

    return _snapshot;
  }
}
