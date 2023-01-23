import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Stack extends TStatelessWidget {
  T_Stack({
    Key? key,
    required widgetProps,
    required pagePath,
    childData = const {},
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          childData: childData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  List<Widget> _getChildren() {
    var index = 0;
    List<LayoutProps> children = props?.children ?? [];
    return children.map((child) {
      index++;

      Widget item = TWidgets(
        key: ValueKey(index),
        layout: child,
        pagePath: pagePath,
        childData: childData,
      );

      if (child.positioned != null) {
        var left = child.positioned?["left"];
        var right = child.positioned?["right"];
        var top = child.positioned?["top"];
        var bottom = child.positioned?["bottom"];
        item = Positioned(
          key: ValueKey(index),
          left: utils.computeSizeValue(left, contextData),
          right: utils.computeSizeValue(right, contextData),
          top: utils.computeSizeValue(top, contextData),
          bottom: utils.computeSizeValue(bottom, contextData),
          child: item,
        );
      }

      return item;
    }).toList();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: _getChildren(),
    );
  }
}
