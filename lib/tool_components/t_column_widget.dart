import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:provider/provider.dart';

class T_Column extends T_StatelessWidget {
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

  LayoutProps? _props;
  LayoutProps? _prevProps;
  Widget _snapshot = const SizedBox.shrink();

  List<Widget> _getChildren() {
    var index = 0;
    List<LayoutProps> children = _props?.children ?? [];
    return children.map((child) {
      index++;
      return T_Widgets(
        key: ValueKey(index),
        layout: child,
        pagePath: pagePath,
        contextData: parentData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> contextData =
        context.select((ContextStateProvider value) {
      return Map<String, dynamic>.from(value.contextData[pagePath] ?? {});
    });

    _props = utils.computeWidgetProps(
      widgetProps,
      contextData,
    );

    if (_props != null) {
      if (_props == _prevProps) {
        return _snapshot;
      }

      if (_props?.hidden == true) {
        return const SizedBox.shrink();
      }

      _prevProps = _props;
      _snapshot = Column(
        key: getBindingKey(),
        children: _getChildren(),
      );
    }

    return _snapshot;
  }
}
