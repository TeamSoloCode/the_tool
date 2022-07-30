import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_select_field_widget.dart';
import 'package:the_tool/tool_components/fields/t_text_field_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_Fields extends T_Widget {
  @override
  UtilsManager utils = getIt<UtilsManager>();

  T_Fields({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_Fields> createState() => _T_FieldsState();
}

Timer? _debounce;

class _T_FieldsState extends StateWidget<T_Fields> {
  final textFieldController = TextEditingController();
  dynamic value;
  dynamic prevValue;

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
          widgetUuid: widget.widgetUuid,
        );
      case "select":
        return T_SelectField(
          pagePath: widget.pagePath,
          widgetProps: widget.widgetProps,
          contextData: widget.parentData,
          widgetUuid: widget.widgetUuid,
        );
      default:
        throw Exception("$fieldType field type is not supported!");
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      if (_props.hidden == true) {
        return const SizedBox.shrink();
      }

      _snapshot = _computeFields(_props, context);
    }

    return _snapshot;
  }
}
