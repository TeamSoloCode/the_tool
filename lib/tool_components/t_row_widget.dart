import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/page_widget.dart';
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

  List<Widget> _computeChildren(List<Map<String, dynamic>>? children) {
    return (children ?? []).map((child) {
      return T_Widgets(
        layout: child,
        pagePath: pageName,
        contextData: contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _computeChildren(widgetProps["children"]),
    );
  }
}
