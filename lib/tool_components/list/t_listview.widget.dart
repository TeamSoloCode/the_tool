import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TListView extends TWidget {
  TListView(TWidgetProps twidget) : super(twidget);

  @override
  State<TListView> createState() => _TListViewState();
}

class _TListViewState extends TStatefulWidget<TListView> {
  ScrollController? _controller;

  Widget _computeListView(LayoutProps props) {
    if (props.itemLayout == null) return const Offstage();
    if (props.name == null) {
      throw Exception(
        "List widget must to have 'name' property (${widget.pagePath})",
      );
    }

    var listData = widget.getContexData()[props.name];

    if (listData is! List) {
      throw Exception(
        "List data must be a array of object (${widget.pagePath})",
      );
    }

    return ListView.separated(
      controller: _controller,
      separatorBuilder: (context, index) {
        return props.separator != null
            ? TWidgets(
                key: ValueKey(listData[index]?['id'] ?? index),
                layout: props.separator!,
                pagePath: widget.pagePath,
                childData: listData[index],
              )
            : const Offstage();
      },
      itemCount: listData.length,
      // itemExtent: props.itemExtent,
      itemBuilder: (context, index) {
        if (listData[index] is! Map) {
          throw Exception(
            "Item in list data must be an Map object (${widget.pagePath})",
          );
        }

        return TWidgets(
          key: ValueKey(listData[index]?['id'] ?? index),
          layout: props.itemLayout!,
          pagePath: widget.pagePath,
          childData: listData[index],
        );
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (widget.props != null) {
      snapshot = _computeListView(widget.props!);
    }

    return snapshot;
  }
}
