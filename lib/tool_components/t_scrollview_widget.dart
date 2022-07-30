import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_ScrollView extends T_StatelessWidget {
  T_ScrollView({
    Key? key,
    required widgetProps,
    required pagePath,
    required contextData,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );
  List<Widget> _items = [];
  List<Widget> _computeChildren(
      List<dynamic>? children, Map<String, dynamic> contextData) {
    var index = 0;
    return (children ?? []).map((child) {
      index++;
      var tWidget = T_Widgets(
        key: ValueKey(index),
        layout: child,
        pagePath: pagePath,
        contextData: contextData,
      );
      return tWidget;
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (props != null) {
      if (props?.hidden == true) {
        return const SizedBox.shrink();
      }

      _items = _computeChildren(props?.children, contextData);
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

    return snapshot;
  }
}
