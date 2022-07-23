import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_select_field_widget.dart';
import 'package:the_tool/tool_components/fields/t_text_field_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

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
  LayoutProps? prevWidgetProps;
  LayoutProps? widgetProps;
  dynamic value;
  dynamic prevValue;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  bool shouldWidgetUpdate() {
    widgetProps = widget.widgetProps;
    String? name = widgetProps?.name;

    value = widget.parentData[name] ?? "";
    bool isSameValue = false;

    if (value is Map || value is List) {
      isSameValue = const DeepCollectionEquality().equals(value, prevValue);
    } else {
      isSameValue = (value == prevValue);
    }

    var shouldUpdate = !isSameValue ||
        !const DeepCollectionEquality().equals(
          prevWidgetProps,
          widgetProps,
        );

    return shouldUpdate;
  }

  Widget _computeFields(
    LayoutProps? widgetProps,
    BuildContext context,
  ) {
    String? fieldType = widgetProps?.fieldType;

    prevValue = value;
    prevWidgetProps = widgetProps;

    switch (fieldType) {
      case "text":
        return T_TextField(
          pagePath: widget.pagePath,
          widgetProps: widgetProps,
          contextData: widget.parentData,
        );
      case "select":
        return T_SelectField(
          pagePath: widget.pagePath,
          widgetProps: widgetProps,
          contextData: widget.parentData,
        );
      default:
        throw Exception("$fieldType field type is not supported!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShouldWidgetUpdate(
      key: widget.getBindingKey(),
      builder: (context) {
        return _computeFields(widget.widgetProps, context);
      },
      shouldWidgetUpdate: shouldWidgetUpdate(),
    );
  }
}
