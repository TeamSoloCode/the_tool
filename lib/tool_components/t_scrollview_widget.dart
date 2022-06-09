import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_ScrollView extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();
  final String pageName;
  T_ScrollView({
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

  List<Widget> _computeChildren(List<dynamic>? children) {
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
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    var items = _computeChildren(widgetProps["children"]);

    return CustomScrollView(
      slivers: [
        SliverList(
          key: centerKey,
          delegate: SliverChildBuilderDelegate((context, index) {
            return items.elementAt(index);
          }, childCount: items.length),
        )
      ],
    );
  }
}
