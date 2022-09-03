import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/style_utils.dart';
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

      Widget item = TWidgets(
        key: ValueKey(index),
        layout: child,
        pagePath: pagePath,
        contextData: parentData,
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
    if (props != null) {
      snapshot = Column(
        key: getBindingKey(),
        mainAxisAlignment: mainAxisAlignment,
        children: _getChildren(),
      );

      if (props?.scrollable == true) {
        snapshot = ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: snapshot,
          ),
        );
      }
    }

    return snapshot;
  }
}
