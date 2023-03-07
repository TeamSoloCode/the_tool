import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/common_interfaces.dart';

class T_Expanded extends TStatelessWidget {
  T_Expanded(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    snapshot = Expanded(
      key: getBindingKey(),
      flex: props?.flex ?? 1,
      child: TWidgets(
        layout: props?.child ?? const LayoutProps(),
        pagePath: pagePath,
        childData: childData,
      ),
    );

    return snapshot;
  }
}
