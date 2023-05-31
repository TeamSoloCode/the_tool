import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TGrid extends TWidget {
  TGrid(TWidgetProps twidget) : super(twidget);

  @override
  State<TGrid> createState() => _TGridState();
}

class _TGridState extends TStatefulWidget<TGrid> {
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
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _items = _computeChildren(_props.children);
      widget.snapshot = GridView.builder(
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

    return widget.snapshot;
  }
}
