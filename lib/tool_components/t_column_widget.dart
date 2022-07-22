import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:uuid/uuid.dart';

class T_Column extends T_Widget {
  final String pagePath;
  T_Column({
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
  State<T_Column> createState() => _T_ColumnState();
}

class _T_ColumnState extends State<T_Column> {
  final widgetUuid = const Uuid().v4();
  List<Widget> _getChildren() {
    var index = 0;
    List<LayoutProps> children = widget.widgetProps.children ?? [];
    return children.map((child) {
      index++;
      return T_Widgets(
        key: ValueKey(index),
        layout: child,
        pagePath: widget.pagePath,
        contextData: widget.contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.getBindingKey() ?? ValueKey(widgetUuid),
      children: _getChildren(),
    );
  }
}
