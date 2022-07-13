import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Expanded extends T_Widget {
  final String pagePath;
  T_Expanded({
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
  State<T_Expanded> createState() => _T_ExpandedState();
}

class _T_ExpandedState extends State<T_Expanded> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.widgetProps.flex ?? 1,
      child: T_Widgets(
        layout: widget.widgetProps.child ?? const LayoutProps(),
        pagePath: widget.pagePath,
        contextData: widget.contextData,
      ),
    );
  }
}
