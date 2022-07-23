import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:provider/provider.dart';

class T_Expanded extends T_StatelessWidget {
  T_Expanded({
    Key? key,
    required widgetProps,
    required pagePath,
    required parentData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: parentData,
          pagePath: pagePath,
        );

  LayoutProps? _props;
  LayoutProps? _prevProps;
  Widget _snapshot = const SizedBox.shrink();
  Map<String, dynamic> _contextData = {};

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? contextData = {};
    _props = context.select((ContextStateProvider value) {
      var data = Map<String, dynamic>.from(
        value.contextData[pagePath] ?? {},
      );

      contextData = data;

      return utils.computeWidgetProps(
        widgetProps,
        data,
      );
    });

    if (_props?.hidden == true) {
      return const SizedBox.shrink();
    }

    _prevProps = _props;

    _snapshot = Expanded(
      key: getBindingKey(),
      flex: _props?.flex ?? 1,
      child: T_Widgets(
        layout: _props?.child ?? const LayoutProps(),
        pagePath: pagePath,
        contextData: parentData,
      ),
    );

    return _snapshot;
  }
}
