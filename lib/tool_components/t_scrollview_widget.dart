import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_ScrollView extends T_StateLessWidget {
  UtilsManager utils = getIt<UtilsManager>();
  final String pagePath;

  T_ScrollView({
    Key? key,
    required executeJS,
    required widgetProps,
    required this.pagePath,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  List<Widget> _items = [];

  List<Widget> _computeChildren(List<dynamic>? children) {
    return (children ?? []).map((child) {
      var tWidget = T_Widgets(
        layout: child,
        pagePath: pagePath,
        contextData: contextData,
      );
      return tWidget;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    _items = _computeChildren(widgetProps.children);
    if (widgetProps.sliverListType == "fixed_extent_list") {
      assert(
        widgetProps.itemExtent != null,
        "If sliverListType = \"fixed_extent_list\", please provide \"itemExtent\" with type number",
      );
    }

    return CustomScrollView(
      slivers: [
        if (widgetProps.sliverListType == "fixed_extent_list")
          SliverFixedExtentList(
            key: const ValueKey<String>('sliver-fixed-list'),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _items.elementAt(index);
              },
              childCount: _items.length,
            ),
            itemExtent: widgetProps.itemExtent ?? 100,
          ),
        if (widgetProps.sliverListType == null)
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
  }
}
