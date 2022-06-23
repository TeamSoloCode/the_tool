import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/tool_components/fields/t_select_field_widget.dart';
import 'package:the_tool/tool_components/fields/t_text_field_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_Fields extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();

  T_Fields({
    Key? key,
    required executeJS,
    required widgetProps,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  @override
  State<T_Fields> createState() => _T_FieldsState();
}

Timer? _debounce;

class _T_FieldsState extends State<T_Fields> {
  final textFieldController = TextEditingController();
  Map<String, dynamic> prevWidgetProps = {};
  Map<String, dynamic> widgetProps = {};
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
    String? name = widgetProps["name"];

    value = widget.contextData[name] ?? "";
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
    Map<String, dynamic>? widgetProps,
    BuildContext context,
  ) {
    String? fieldType = widgetProps?["fieldType"];

    prevValue = value;
    prevWidgetProps = widgetProps ?? {};

    switch (fieldType) {
      case "text":
        return T_TextField(
          executeJS: widget.executeJS,
          widgetProps: widgetProps,
          contextData: widget.contextData,
        );
      case "select":
        return T_SelectField(
          executeJS: widget.executeJS,
          widgetProps: widgetProps,
          contextData: widget.contextData,
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
