import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_Clickable extends TWidget {
  T_Clickable({
    Key? key,
    required widgetUuid,
    required widgetProps,
    required pagePath,
    childData = const {},
  }) : super(
          key: key,
          childData: childData,
          widgetUuid: widgetUuid,
          pagePath: pagePath,
          widgetProps: widgetProps,
        );

  @override
  State<T_Clickable> createState() => _T_Clickable();
}

class _T_Clickable extends TStatefulWidget<T_Clickable> {
  @override
  Widget buildWidget(BuildContext context) {
    return SizedBox();
  }
}
