import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

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
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    _items = _computeChildren(widget.widgetProps.children);

    return CustomScrollView(
      slivers: [
        SliverList(
          key: centerKey,
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
