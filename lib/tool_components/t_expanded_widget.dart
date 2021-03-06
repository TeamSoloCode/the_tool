import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Expanded extends TStatelessWidget {
  T_Expanded({
    Key? key,
    required widgetProps,
    required pagePath,
    required parentData,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: parentData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  Widget buildWidget(BuildContext context) {
    snapshot = Expanded(
      key: getBindingKey(),
      flex: props?.flex ?? 1,
      child: TWidgets(
        layout: props?.child ?? const LayoutProps(),
        pagePath: pagePath,
        contextData: contextData,
      ),
    );

    return snapshot;
  }
}
