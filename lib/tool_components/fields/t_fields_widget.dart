import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_select_field_widget.dart';
import 'package:the_tool/tool_components/fields/t_text_field_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';

class T_Fields extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();

  T_Fields({
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
  State<T_Fields> createState() => _T_FieldsState();
}

Timer? _debounce;

class _T_FieldsState extends State<T_Fields> {
  final textFieldController = TextEditingController();
  dynamic value;
  dynamic prevValue;

  Widget _snapshot = const SizedBox.shrink();
  LayoutProps? _props;
  LayoutProps? _prevProps;

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  Widget _computeFields(
    LayoutProps? widgetProps,
    BuildContext context,
  ) {
    String? fieldType = widgetProps?.fieldType;

    prevValue = value;

    switch (fieldType) {
      case "text":
        return T_TextField(
          pagePath: widget.pagePath,
          widgetProps: widget.widgetProps,
          contextData: widget.parentData,
        );
      case "select":
        return T_SelectField(
          pagePath: widget.pagePath,
          widgetProps: widget.widgetProps,
          contextData: widget.parentData,
        );
      default:
        throw Exception("$fieldType field type is not supported!");
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
      _snapshot = _computeFields(_props, context);
    }

    return _snapshot;
  }
}
