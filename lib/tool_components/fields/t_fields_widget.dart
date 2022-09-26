import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_datetime_field.dart'
    deferred as field_datetime;
import 'package:the_tool/tool_components/fields/t_select_field_widget.dart'
    deferred as field_select;
import 'package:the_tool/tool_components/fields/t_text_field_widget.dart'
    deferred as field_text;
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_Fields extends TWidget {
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

class _T_FieldsState extends TStatefulWidget<T_Fields> {
  final textFieldController = TextEditingController();
  dynamic value;
  dynamic prevValue;

  bool _loadedWidget = false;

  @override
  void initState() {
    _loadLibrary(widget.widgetProps, context);
    super.initState();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  Future<void> _loadLibrary(
    LayoutProps? widgetProps,
    BuildContext context,
  ) async {
    String? fieldType = widgetProps?.fieldType;
    prevValue = value;

    switch (fieldType) {
      case "text":
        await field_text.loadLibrary();

        break;
      case "select":
        await field_select.loadLibrary();
        break;
      case "datetime":
        await field_datetime.loadLibrary();
        break;
      default:
        throw Exception("$fieldType field type is not supported!");
    }

    setState(() {
      _loadedWidget = true;
    });
  }

  Widget _computeFields(
    LayoutProps? widgetProps,
    BuildContext context,
  ) {
    String? fieldType = widgetProps?.fieldType;

    prevValue = value;

    switch (fieldType) {
      case "text":
        return field_text.T_TextField(
          pagePath: widget.pagePath,
          widgetProps: widget.widgetProps,
          contextData: widget.parentData,
          widgetUuid: widget.widgetUuid,
        );
      case "select":
        return field_select.T_SelectField(
          pagePath: widget.pagePath,
          widgetProps: widget.widgetProps,
          contextData: widget.parentData,
          widgetUuid: widget.widgetUuid,
        );
      case "datetime":
        return field_datetime.T_Datetime(
          widgetProps: widgetProps,
          contextData: widget.parentData,
          pagePath: widget.pagePath,
          widgetUuid: widget.widgetUuid,
        );
      default:
        throw Exception("$fieldType field type is not supported!");
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (_loadedWidget) {
      Widget _snapshot = widget.snapshot;
      LayoutProps? _props = widget.props;

      if (_props != null) {
        _snapshot = _computeFields(_props, context);
      }

      return _snapshot;
    }
    return const SizedBox();
  }
}
