import 'package:flutter/material.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_ScrollView extends TStatelessWidget {
  T_ScrollView(TWidgetProps twidget) : super(twidget);

  List<Widget> _items = [];

  List<Widget> _computeChildren(
    List<dynamic>? children,
    Map<String, dynamic> childData,
  ) {
    var index = 0;
    return (children ?? []).map((child) {
      index++;
      var tWidget = TWidgets(
        key: ValueKey(index),
        layout: child,
        pagePath: pagePath,
        childData: childData,
      );
      return tWidget;
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    _items = _computeChildren(
      props?.children,
      childData,
    );

    if (props?.sliverListType == "fixed_extent_list") {
      assert(
        props?.itemExtent != null,
        "If sliverListType = \"fixed_extent_list\", please provide \"itemExtent\" with type number",
      );
    }

    snapshot = CustomScrollView(
      key: getBindingKey(),
      slivers: [
        if (props?.sliverListType == "fixed_extent_list")
          SliverFixedExtentList(
            key: const ValueKey<String>('sliver-fixed-list'),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _items.elementAt(index);
              },
              childCount: _items.length,
            ),
            itemExtent: props?.itemExtent ?? 100,
          ),
        if (props?.sliverListType == null)
          SliverList(
            key: const ValueKey<String>('sliver-list'),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _items.elementAt(index);
              },
              childCount: _items.length,
            ),
          )
      ],
    );

    return snapshot;
  }
}
