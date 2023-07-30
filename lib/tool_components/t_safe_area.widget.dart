import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TSafeArea extends TStatelessWidget {
  TSafeArea(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    if (props != null) {
      snapshot = SafeArea(
        key: getBindingKey(),
        child: TWidgets(
          layout: props!.child!,
          pagePath: pagePath,
          childData: childData,
        ),
      );
    }

    return snapshot;
  }
}
