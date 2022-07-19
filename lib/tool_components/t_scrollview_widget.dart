import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';

class T_ScrollView extends T_Widget {
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

  @override
  State<T_ScrollView> createState() => _T_ScrollViewState();
}

class _T_ScrollViewState extends State<T_ScrollView> {
  List<Widget> _items = [];
  final widgetUuid = const Uuid().v4();

  List<Widget> _computeChildren(List<dynamic>? children) {
    return (children ?? []).map((child) {
      var tWidget = T_Widgets(
        layout: child,
        pagePath: widget.pagePath,
        contextData: widget.contextData,
      );
      return tWidget;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var props = widget.widgetProps;
    _items = _computeChildren(props.children);
    if (props.sliverListType == "fixed_extent_list") {
      assert(
        props.itemExtent != null,
        "If sliverListType = \"fixed_extent_list\", please provide \"itemExtent\" with type number",
      );
    }

    return CustomScrollView(
      key: widget.getBindingKey() ?? ValueKey(widgetUuid),
      slivers: [
        if (props.sliverListType == "fixed_extent_list")
          SliverFixedExtentList(
            key: const ValueKey<String>('sliver-fixed-list'),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _items.elementAt(index);
              },
              childCount: _items.length,
            ),
            itemExtent: props.itemExtent ?? 100,
          ),
        if (props.sliverListType == null)
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
