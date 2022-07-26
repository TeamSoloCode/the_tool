import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Row extends T_StatelessWidget {
  T_Row({
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

  List<Widget> _computeChildren(
    List<dynamic>? children,
    Map<String, dynamic> contextData,
  ) {
    return (children ?? []).map((child) {
      return T_Widgets(
        layout: child,
        pagePath: pagePath,
        contextData: contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    watchContextState(context);

    if (props?.hidden == true) {
      return const SizedBox.shrink();
    }

    prevProps = props;

    var mainAxisAlignment = ThemeDecoder.decodeMainAxisAlignment(
          props?.mainAxisAlignment,
        ) ??
        MainAxisAlignment.start;

    snapshot = Row(
      key: getBindingKey(),
      mainAxisAlignment: mainAxisAlignment,
      children: _computeChildren(props?.children, contextData),
    );
    return snapshot;
  }
}
