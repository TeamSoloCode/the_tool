import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_ClipOval extends TStatelessWidget {
  T_ClipOval({
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
  Widget buildWidget(BuildContext context) {
    return ClipOval(
      key: getBindingKey(),
      child: TWidgets(
        layout: props!.child!,
        pagePath: pagePath,
        childData: childData,
      ),
    );
  }
}
