import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Column extends T_Widget {
  final String pageName;
  T_Column({
    Key? key,
    required executeJS,
    required widgetProps,
    required this.pageName,
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
  List<Widget> _getChildren() {
    List<LayoutProps> children = widget.widgetProps.children ?? [];

    return children.map((child) {
      return T_Widgets(
        layout: child,
        pagePath: widget.pageName,
        contextData: widget.contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getChildren(),
    );
  }
}
