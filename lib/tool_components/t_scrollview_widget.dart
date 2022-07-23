import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:provider/provider.dart';

class T_ScrollView extends T_StatelessWidget {
  T_ScrollView({
    Key? key,
    required widgetProps,
    required pagePath,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
        );

  List<Widget> _items = [];
  LayoutProps? _props;
  LayoutProps? _prevProps;
  Widget _snapshot = const SizedBox.shrink();
  Map<String, dynamic> _contextData = {};

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
  Widget build(BuildContext context) {
    _props = context.select((ContextStateProvider value) {
      var data = Map<String, dynamic>.from(
        value.contextData[pagePath] ?? {},
      );

      _contextData = data;

      return utils.computeWidgetProps(
        widgetProps,
        data,
      );
    });

    if (_props?.hidden == true) {
      return const SizedBox.shrink();
    }

    _prevProps = _props;

    _items = _computeChildren(_props?.children, _contextData);
    if (_props?.sliverListType == "fixed_extent_list") {
      assert(
        _props?.itemExtent != null,
        "If sliverListType = \"fixed_extent_list\", please provide \"itemExtent\" with type number",
      );
    }

    _snapshot = CustomScrollView(
      key: getBindingKey(),
      slivers: [
        if (_props?.sliverListType == "fixed_extent_list")
          SliverFixedExtentList(
            key: const ValueKey<String>('sliver-fixed-list'),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _items.elementAt(index);
              },
              childCount: _items.length,
            ),
            itemExtent: _props?.itemExtent ?? 100,
          ),
        if (_props?.sliverListType == null)
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

    return _snapshot;
  }
}
