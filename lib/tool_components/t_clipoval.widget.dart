import 'package:flutter/material.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_ClipOval extends TStatelessWidget {
  T_ClipOval(TWidgetProps twidget) : super(twidget);

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
