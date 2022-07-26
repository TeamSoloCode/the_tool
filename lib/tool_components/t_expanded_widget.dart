import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Expanded extends T_StatelessWidget {
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
  Widget build(BuildContext context) {
    watchContextState(context);

    if (props?.hidden == true) {
      return const SizedBox.shrink();
    }

    prevProps = props;

    snapshot = Expanded(
      key: getBindingKey(),
      flex: props?.flex ?? 1,
      child: T_Widgets(
        layout: props?.child ?? const LayoutProps(),
        pagePath: pagePath,
        contextData: contextData,
      ),
    );

    return snapshot;
  }
}
