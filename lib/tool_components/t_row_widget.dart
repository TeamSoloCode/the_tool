import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class T_Row extends T_StatelessWidget {
  T_Row({
    Key? key,
    required widgetProps,
    required pagePath,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
        );

  LayoutProps? _props;
  LayoutProps? _prevProps;
  Widget _snapshot = const SizedBox.shrink();

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
    Map<String, dynamic> contextData = Map<String, dynamic>.from({});
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

    var mainAxisAlignment = ThemeDecoder.decodeMainAxisAlignment(
          _props?.mainAxisAlignment,
        ) ??
        MainAxisAlignment.start;

    _snapshot = Row(
      key: getBindingKey(),
      mainAxisAlignment: mainAxisAlignment,
      children: _computeChildren(_props?.children, contextData),
    );
    return _snapshot;
  }
}
