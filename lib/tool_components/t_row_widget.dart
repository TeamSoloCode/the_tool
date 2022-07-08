import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_Row extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();
  final String pageName;
  T_Row({
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
  State<T_Row> createState() => _T_RowState();
}

class _T_RowState extends State<T_Row> {
  List<Widget> _computeChildren(List<dynamic>? children) {
    return (children ?? []).map((child) {
      return T_Widgets(
        layout: child,
        pagePath: widget.pageName,
        contextData: widget.contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var mainAxisAlignment = ThemeDecoder.decodeMainAxisAlignment(
          widget.widgetProps.mainAxisAlignment,
        ) ??
        MainAxisAlignment.start;

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: _computeChildren(widget.widgetProps.children),
    );
  }
}
