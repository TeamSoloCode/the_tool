import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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

  Widget _computeFields(Map<String, dynamic>? children, BuildContext context) {
    String? fieldType = widgetProps["fieldType"];
    switch (fieldType) {
      case "text":
        return FormBuilderTextField(
          name: 'age',
          decoration: const InputDecoration(
            labelText: 'Required field number, with 10 chars max',
          ),
          onChanged: (nextValue) {},
          onEditingComplete: () {
            log("onEditingComplete");
          },

          // valueTransformer: (text) => num.tryParse(text),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Required field"),
            FormBuilderValidators.numeric(errorText: "Number field"),
            FormBuilderValidators.max(10, errorText: "Only 10 character!"),
          ]),
          keyboardType: TextInputType.number,
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
