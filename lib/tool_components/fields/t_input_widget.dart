import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_Fields extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();
  Timer? _debounce;

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

  Widget _computeFields(Map<String, dynamic>? children, BuildContext context) {
    String? fieldType = widgetProps["fieldType"];
    String? name = widgetProps["name"];
    if (name == null) throw Exception("Field have to have'name' props");

    void _debounceTextChanged(String? text) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        setPageData({name: text});
      });
    }

    switch (fieldType) {
      case "text":
        return FormBuilderTextField(
          name: name,
          decoration: const InputDecoration(
            labelText: 'Required field number, with 10 chars max',
          ),
          onChanged: (text) {
            _debounceTextChanged(text);
          },
          onEditingComplete: () {
            log("onEditingComplete");
          },
          // valueTransformer: (text) => num.tryParse(text),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Required field"),
            FormBuilderValidators.numeric(errorText: "Number field"),
            FormBuilderValidators.max(10, errorText: "Only 10 character!"),
          ]),
          keyboardType: TextInputType.text,
        );
      default:
        throw Exception("$fieldType field type is not supported!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _computeFields(widgetProps, context);
  }
}
