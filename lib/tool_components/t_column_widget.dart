import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Column extends TStatelessWidget {
  T_Column({
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

  List<Widget> _getChildren() {
    var index = 0;
    List<LayoutProps> children = props?.children ?? [];
    return children.map((child) {
      index++;
      return Container(
        child: TWidgets(
          key: ValueKey(index),
          layout: child,
          pagePath: pagePath,
          contextData: parentData,
        ),
      );
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (props != null) {
      snapshot = Column(
        key: getBindingKey(),
        children: _getChildren(),
      );
    }

    return snapshot;
  }
}
