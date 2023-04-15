import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:json_theme/json_theme.dart';

mixin FieldMixin {
  final UtilsManager _utils = UtilsManager();

  InputDecoration computeFieldDecoration(
    LayoutProps? widgetProps, {
    required TWidget thisWidget,
    String? errorMessage,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixText: widgetProps?.prefixText,
      suffixText: widgetProps?.suffixText,
      hintText: widgetProps?.hintText,
      labelText: widgetProps?.labelText,
      errorText: errorMessage,
      suffixIcon: suffixIcon ?? _generateSuffixIcon(widgetProps, thisWidget),
      suffixIconColor: ThemeDecoder.decodeColor(widgetProps?.suffixIconColor),
      prefixIcon: widgetProps!.prefixIcon != null
          ? Icon(MdiIcons.fromString(widgetProps.prefixIcon!))
          : null,
      prefixIconColor: ThemeDecoder.decodeColor(widgetProps.prefixIconColor),
    );
  }

  Widget? _generateSuffixIcon(LayoutProps? widgetProps, TWidget widget) {
    Widget? suffixIcon;
    var suffixIconValue = widgetProps?.suffixIcon;
    if (suffixIconValue == null) return suffixIcon;
    if (UtilsManager.isValueBinding(suffixIconValue)) {
      suffixIconValue = widget.utils.bindingValueToText(
        widget.getContexData(),
        suffixIconValue,
      );
    }

    suffixIcon = Icon(MdiIcons.fromString(suffixIconValue));

    if (widgetProps?.onClickSuffixIcon != null) {
      return IconButton(
        icon: suffixIcon,
        onPressed: () {
          if (widgetProps?.onClickSuffixIcon == null) return;

          widget.executeJSWithPagePath("${widgetProps?.onClickSuffixIcon}()");
        },
      );
    }

    return suffixIcon;
  }

  /// This validator compute function is used for SelectField
  List<String? Function(dynamic)> computeFieldValidators(
    List<Map<String, dynamic>>? validatorsMap,
    Map<String, dynamic> contextData,
  ) {
    return validatorsMap != null
        ? validatorsMap
            .map((validator) {
              dynamic errorText = validator["errorText"];
              switch (validator["type"]) {
                case "is_required":
                  return FormBuilderValidators.required(errorText: errorText);

                case "max":
                  dynamic maxValue = UtilsManager.isValueBinding(
                          validator["maxValue"].toString())
                      ? double.tryParse(_utils
                          .bindingValueToProp(
                              contextData, validator["maxValue"])
                          .toString())
                      : double.tryParse(validator["maxValue"].toString());

                  if (maxValue == null) {
                    throw Exception(
                      "maxValue of max validator must be a number",
                    );
                  }

                  var inclusive = UtilsManager.isTruthy(validator["inclusive"]);

                  return FormBuilderValidators.max(maxValue,
                      inclusive: inclusive, errorText: errorText);

                case "min":
                  dynamic minValue = UtilsManager.isValueBinding(
                          validator["minValue"].toString())
                      ? double.tryParse(_utils
                          .bindingValueToProp(
                              contextData, validator["minValue"])
                          .toString())
                      : double.tryParse(validator["minValue"].toString());

                  if (minValue == null) {
                    throw Exception(
                      "minValue of min validator must be a number",
                    );
                  }

                  var inclusive = UtilsManager.isTruthy(validator["inclusive"]);

                  return FormBuilderValidators.min(minValue,
                      inclusive: inclusive, errorText: errorText);

                case "max_length":
                  int? maxValue =
                      int.tryParse(validator["maxLengthValue"].toString());

                  if (maxValue == null) {
                    throw Exception(
                      "maxLengthValue of max_length validator must be a number",
                    );
                  }

                  return FormBuilderValidators.maxLength(maxValue,
                      errorText: errorText);

                case "min_length":
                  int? minValue =
                      int.tryParse(validator["minLengthValue"].toString());

                  if (minValue == null) {
                    throw Exception(
                      "minLengthValue of min_length validator must be a number",
                    );
                  }

                  return FormBuilderValidators.minLength(minValue,
                      errorText: errorText);

                case "notEqual":
                  return FormBuilderValidators.notEqual(validator["value"],
                      errorText: errorText);

                default:
                  return null;
              }
            })
            .where((validator) => validator != null)
            .cast<String? Function(dynamic)>()
            .toList()
        : [];
  }

  /// This validator compute function is used for TextField
  List<String? Function(String?)> computeCommonValidators(
    List<Map<String, dynamic>>? validatorsMap,
    Map<String, dynamic> contextData,
  ) {
    List<String? Function(String?)> validators = validatorsMap != null
        ? validatorsMap
            .map((validator) {
              switch (validator["type"]) {
                case "is_email":
                  return FormBuilderValidators.email(
                    errorText: validator["errorText"],
                  );
                case "numeric":
                  return FormBuilderValidators.numeric(
                    errorText: validator["errorText"],
                  );
                case "integer":
                  return FormBuilderValidators.integer(
                    errorText: validator["errorText"],
                  );
                case "dateString":
                  return FormBuilderValidators.dateString(
                    errorText: validator["errorText"],
                  );
                default:
                  return null;
              }
            })
            .where((validator) => validator != null)
            .cast<String? Function(String?)>()
            .toList()
        : [];

    var fieldValidators = computeFieldValidators(validatorsMap, contextData);
    return [...validators, ...fieldValidators];
  }
}
