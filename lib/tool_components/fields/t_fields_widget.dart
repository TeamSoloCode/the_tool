import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_tool/constants.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_custom_field.field.dart'
    deferred as field_custom;
import 'package:the_tool/tool_components/fields/t_datetime_field.dart'
    deferred as field_datetime;
import 'package:the_tool/tool_components/fields/t_image_picker.field.dart'
    deferred as field_image;
import 'package:the_tool/tool_components/fields/t_select_field_widget.dart'
    deferred as field_select;
import 'package:the_tool/tool_components/fields/t_text_field_widget.dart'
    deferred as field_text;
import 'package:the_tool/tool_components/fields/t_checkbox_field.dart'
    deferred as field_checkbox;

import 'package:the_tool/tool_components/fields/t_multiple_select.field.dart'
    deferred as field_multi_select;
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TFields extends TWidget {
  TFields(TWidgetProps twidget) : super(twidget);

  @override
  State<TFields> createState() => _TFieldsState();
}

class _TFieldsState extends TStatefulWidget<TFields> {
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
      case CurrencyFieldType:
        await field_text.loadLibrary();
        break;
      case "select":
        await field_select.loadLibrary();
        break;
      case "datetime":
      case "date":
      case "time":
        await field_datetime.loadLibrary();
        break;
      case "checkbox":
        await field_checkbox.loadLibrary();
        break;
      case "image":
        await field_image.loadLibrary();
        break;
      case "custom":
        await field_custom.loadLibrary();
        break;
      case "multiple_select":
        await field_multi_select.loadLibrary();
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

    var tWidgetProps = TWidgetProps(
      key: Key(widget.widgetUuid),
      widgetProps: widget.widgetProps,
      pagePath: widget.pagePath,
      widgetUuid: widget.widgetUuid,
      childData: widget.childData,
    );

    switch (fieldType) {
      case "text":
      case CurrencyFieldType:
        return field_text.TTextField(tWidgetProps);
      case "select":
        return field_select.TSelectField(tWidgetProps);
      case "datetime":
      case "date":
      case "time":
        return field_datetime.TDatetimeField(tWidgetProps);
      case "checkbox":
        return field_checkbox.TCheckbox(tWidgetProps);
      case "image":
        return field_image.TImagePickerField(tWidgetProps);
      case "custom":
        return field_custom.TCustomField(tWidgetProps);
      case "multiple_select":
        return field_multi_select.TMultiSelectField(tWidgetProps);
      default:
        throw Exception("$fieldType field type is not supported!");
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (_loadedWidget) {
      LayoutProps? _props = widget.props;

      if (_props != null) {
        snapshot = _computeFields(_props, context);
      }

      return snapshot;
    }
    return const Offstage();
  }
}
