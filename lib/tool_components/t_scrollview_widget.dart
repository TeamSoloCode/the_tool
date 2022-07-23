import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class T_ScrollView extends T_Widget {
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

  @override
  State<T_ScrollView> createState() => _T_ScrollViewState();
}

class _T_ScrollViewState extends State<T_ScrollView> {
  List<Widget> _items = [];
  final widgetUuid = const Uuid().v4();
  LayoutProps? props;
  LayoutProps? prevProps;
  Widget _snapshot = const SizedBox.shrink();

  Future<void> _computeProps(Map<String, dynamic> contextData) async {
    if (props == null || props != prevProps) {
      var nextProps = await widget.utils.computeWidgetProps(
        widget.widgetProps,
        contextData,
      );

      setState(() {
        prevProps = props;
        props = nextProps;
      });
    }
  }

  List<Widget> _computeChildren(
      List<dynamic>? children, Map<String, dynamic> contextData) {
    var index = 0;
    return (children ?? []).map((child) {
      index++;
      var tWidget = T_Widgets(
        key: ValueKey(index),
        layout: child,
        pagePath: widget.pagePath,
        contextData: contextData,
      );
      return tWidget;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> contextData =
        context.select((ContextStateProvider value) {
      return Map<String, dynamic>.from(
          value.contextData[widget.pagePath] ?? {});
    });

    _computeProps(contextData);

    if (props != null) {
      if (props == prevProps) {
        return _snapshot;
      }

      _items = _computeChildren(props?.children, contextData);

      if (props?.sliverListType == "fixed_extent_list") {
        assert(
          props?.itemExtent != null,
          "If sliverListType = \"fixed_extent_list\", please provide \"itemExtent\" with type number",
        );
      }

      _snapshot = CustomScrollView(
        key: widget.getBindingKey() ?? ValueKey(widgetUuid),
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

      return _snapshot;
    }

    return _snapshot;
  }
}
