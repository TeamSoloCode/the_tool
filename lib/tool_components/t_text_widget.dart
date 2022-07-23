import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:provider/provider.dart';

class T_Text extends T_Widget {
  T_Text({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
        );

  @override
  State<T_Text> createState() => _T_TextState();
}

class _T_TextState extends State<T_Text> {
  var text = "";
  Widget _snapshot = const SizedBox.shrink();
  LayoutProps? _props;
  LayoutProps? _prevProps;

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

    _props = widget.utils.computeWidgetProps(
      widget.widgetProps,
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

      if (kIsWeb) {
        _snapshot = SelectableText(
          _props?.text ?? "",
          style: ThemeDecoder.decodeTextStyle(_props?.toJson()),
        );
      } else {
        _snapshot = Text(
          _props?.text ?? "",
          style: ThemeDecoder.decodeTextStyle(_props?.toJson()),
        );
      }
    }

    return _snapshot;
  }
}
