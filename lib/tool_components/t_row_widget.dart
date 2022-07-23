import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class T_Row extends T_Widget {
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

  @override
  State<T_Row> createState() => _T_RowState();
}

class _T_RowState extends State<T_Row> {
  final widgetUuid = const Uuid().v4();
  LayoutProps? _props;
  LayoutProps? _prevProps;
  Widget _snapshot = const SizedBox.shrink();

  Future<void> _computeProps(Map<String, dynamic> contextData) async {
    var nextProps = await widget.utils.computeWidgetProps(
      widget.widgetProps,
      contextData,
    );

    if (_props != nextProps) {
      setState(() {
        _props = nextProps;
      });
    }
  }

  List<Widget> _computeChildren(
    List<dynamic>? children,
    Map<String, dynamic> contextData,
  ) {
    return (children ?? []).map((child) {
      return T_Widgets(
        layout: child,
        pagePath: widget.pagePath,
        contextData: contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> contextData =
        context.select((ContextStateProvider value) {
      return Map<String, dynamic>.from(
          value.contextData[widget.pagePath] ?? {});
    });

    _computeProps(contextData);

    if (_props != null) {
      if (_props == _prevProps) {
        return _snapshot;
      }

      if (_props?.hidden == true) {
        return const SizedBox.shrink();
      }

      _prevProps = _props;

      var mainAxisAlignment = ThemeDecoder.decodeMainAxisAlignment(
            _props?.mainAxisAlignment,
          ) ??
          MainAxisAlignment.start;

      _snapshot = Row(
        key: widget.getBindingKey() ?? ValueKey(widgetUuid),
        mainAxisAlignment: mainAxisAlignment,
        children: _computeChildren(_props?.children, contextData),
      );
    }
    return _snapshot;
  }
}
