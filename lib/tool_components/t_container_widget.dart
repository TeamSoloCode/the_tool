import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class T_Container extends T_Widget {
  T_Container({
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
  State<T_Container> createState() => _T_ContainerState();
}

class _T_ContainerState extends State<T_Container> {
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

      var cssColor = _props?.backgroundColor;
      Color? color = cssColor != null ? fromCssColor(cssColor) : null;

      _snapshot = Container(
        key: widget.getBindingKey() ?? ValueKey(widgetUuid),
        height: _props?.height,
        width: _props?.width,
        margin: ThemeDecoder.decodeEdgeInsetsGeometry(_props?.margin),
        constraints: BoxConstraints(
          maxHeight: _props?.maxHeight,
          maxWidth: _props?.maxWidth,
          minHeight: _props?.minHeight,
          minWidth: _props?.minWidth,
        ),
        color: color,
        child: T_Widgets(
          layout: _props?.child ?? const LayoutProps(),
          pagePath: widget.pagePath,
          contextData: contextData,
        ),
      );

      return _snapshot;
    }

    return _snapshot;
  }
}
