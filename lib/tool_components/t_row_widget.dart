import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Row extends TStatelessWidget {
  T_Row({
    Key? key,
    required widgetProps,
    required pagePath,
    required contextData,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  List<Widget> _computeChildren(
    List<LayoutProps>? children,
    Map<String, dynamic> contextData,
  ) {
    var index = 0;
    return (children ?? []).map((child) {
      index++;

      Widget item = TWidgets(
        key: ValueKey(index),
        layout: child,
        pagePath: pagePath,
        contextData: contextData,
      );

      if (child.flex != null) {
        item = Expanded(
          key: ValueKey(index),
          flex: child.flex ?? 1,
          child: item,
        );
      }

      return item;
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    var mainAxisAlignment = ThemeDecoder.decodeMainAxisAlignment(
          props?.mainAxisAlignment,
        ) ??
        MainAxisAlignment.start;

    snapshot = Row(
      key: getBindingKey(),
      mainAxisAlignment: mainAxisAlignment,
      children: _computeChildren(props?.children, contextData),
    );

    if (props?.scrollable == true) {
      snapshot = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: snapshot,
      );
    }

    return snapshot;
  }
}
