import 'dart:convert';
import 'dart:developer';
import 'package:eventify/eventify.dart' as eventify;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/twidget_props.dart';

class T_Form extends TWidget {
  T_Form(TWidgetProps twidget) : super(twidget);
  @override
  State<T_Form> createState() => _T_FormState();
}

class _T_FormState extends TStatefulWidget<T_Form> {
  final _formKey = GlobalKey<FormBuilderState>();
  UtilsManager utils = getIt<UtilsManager>();

  Map<String, dynamic> prevFormValue = {};

  late eventify.Listener listener;

  @override
  void initState() {
    final name = widget.widgetProps.name;

    if (name == null) {
      throw Exception("${widget.widgetProps.type} must have 'name' property");
    }

    listener = utils.emitter.on(
      "form:${widget.pagePath}:$name",
      context,
      formAction(),
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    var validateMode = widget.props?.autovalidateMode;
    var fields = _formKey.currentState?.fields;
    bool valueChanged = false;

    fields?.forEach((key, field) {
      var fieldValue = widget.getContexData()[key];

      if (field.runtimeType.toString() == "_FormBuilderDateTimePickerState") {
        fieldValue = DateTime.tryParse(fieldValue.toString());
      }

      field.setValue(fieldValue);
      if (prevFormValue[key] != fieldValue) {
        prevFormValue[key] = fieldValue;
        valueChanged = true;
      }
    });

    var autovalidateMode = ThemeDecoder.decodeAutovalidateMode(validateMode);
    if (autovalidateMode == AutovalidateMode.always && valueChanged) {
      _handleValidationFunction();
    }

    super.didChangeDependencies();

    valueChanged = false;
  }

  @override
  void dispose() {
    listener.cancel();
    utils.emitter.off(listener);
    super.dispose();
  }

  eventify.EventCallback formAction() {
    return (event, cont) async {
      log("Form EventCallback ${event.eventName} ${event.eventData}");
      var data = json.decode(event.eventData as String);
      switch (data["action"]) {
        case "validate":
          var isValid = await _handleValidationFunction();
          utils.evalJS?.emitFormActionResponse(data["actionId"], isValid);
          return;
      }
    };
  }

  Future<bool> _handleValidationFunction() async {
    String? validationFunction = widget.widgetProps.validationFunction;
    Map<Object?, Object?>? errorTextMap;

    if (validationFunction != null && validationFunction.isNotEmpty) {
      errorTextMap = await widget.executeJSWithPagePath(validationFunction, []);
    }

    var isValid = true;

    if (_formKey.currentState != null) {
      loop:
      for (final entry in _formKey.currentState!.fields.entries) {
        final key = entry.key;
        final field = entry.value;
        var errorText = errorTextMap?[key];

        if (errorText == null && field.validate()) {
          continue;
        }

        isValid = false;
        if (errorText != null) {
          field.invalidate(errorText as String);
        }
        break loop;
      }
    }

    return isValid;
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = widget.props;

    assert(
      _props?.name != null,
      "Form need to have name property",
    );

    widget.snapshot = FormBuilder(
      key: _formKey,
      child: TWidgets(
        layout: _props?.child ?? const LayoutProps(),
        pagePath: widget.pagePath,
        childData: widget.childData,
      ),
    );

    return widget.snapshot;
  }
}
