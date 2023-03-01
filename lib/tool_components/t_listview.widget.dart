import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/drawer_props/drawer_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_ListView extends TWidget {
  T_ListView({
    Key? key,
    required widgetProps,
    required widgetUuid,
    required pagePath,
    childData = const {},
  }) : super(
          key: key,
          widgetUuid: widgetUuid,
          pagePath: pagePath,
          widgetProps: widgetProps,
        );

  @override
  State<T_ListView> createState() => _T_ListViewState();
}

class _T_ListViewState extends TStatefulWidget<T_ListView> {
  ScrollController? _controller;
  Widget _computeListView(LayoutProps props) {
    if (props.itemLayout == null) return const Offstage();
    if (props.name == null) {
      throw Exception(
        "List widget must to have 'name' property (${widget.pagePath})",
      );
    }

    var listData = widget.contextData[props.name];

    if (listData is! List) {
      throw Exception(
        "List data must be a array of object (${widget.pagePath})",
      );
    }

    return ListView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        if (listData[index] is! Map) {
          throw Exception(
            "Item in list data must be an object (${widget.pagePath})",
          );
        }

        return TWidgets(
          layout: props.itemLayout!,
          pagePath: widget.pagePath,
          childData: listData[index],
        );
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;

    if (widget.props != null) {
      _snapshot = _computeListView(widget.props!);
    }

    return _snapshot;
  }
}
