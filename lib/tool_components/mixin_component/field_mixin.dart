import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/constants.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/border_props/border_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:json_theme/json_theme.dart';

mixin FieldMixin {
  final UtilsManager _utils = UtilsManager();

  InputDecoration computeFieldDecoration(
    LayoutProps? widgetProps, {
    required TWidget thisWidget,
    String? errorMessage,
    Widget? suffixIcon,
  }) {
    var props = thisWidget.utils.computeHeightAndWidth(
      widgetProps!,
      thisWidget.getContexData(),
    );

    return InputDecoration(
      contentPadding: ThemeDecoder.decodeEdgeInsetsGeometry(props.padding),
      prefixText: props.prefixText,
      suffixText: props.suffixText,
      hintText: props.hintText,
      labelText: props.labelText,
      errorText: errorMessage,
      suffixIcon: suffixIcon ?? generateIcon(props.suffixIcon, thisWidget),
      suffixIconColor: ThemeDecoder.decodeColor(props.suffixIconColor),
      prefixIcon: generateIcon(props.prefixIcon, thisWidget),
      prefixIconColor: ThemeDecoder.decodeColor(props.prefixIconColor),
      fillColor: ThemeDecoder.decodeColor(props.fillColor),
      border: _computeInputBorder(props, props.boxBorder),
      enabledBorder: _computeInputBorder(props, props.enabledBorder),
      focusedBorder: _computeInputBorder(props, props.focusedBorder),
      errorBorder: _computeInputBorder(props, props.errorBorder),
      focusedErrorBorder: _computeInputBorder(props, props.focusedErrorBorder),
      disabledBorder: _computeInputBorder(props, props.disabledBorder),
      enabled: props.enabled ?? true,
      constraints: BoxConstraints(
        maxHeight: props.maxHeight,
        maxWidth: props.maxWidth,
        minHeight: props.minHeight,
        minWidth: props.minWidth,
      ),
    );
  }

  Widget? generateIcon(LayoutProps? icon, TWidget widget) {
    Widget? prefixIcon;
    var iconValue = icon;
    if (iconValue == null) return null;

    prefixIcon = TWidgets(
      layout: iconValue,
      pagePath: widget.pagePath,
      childData: widget.childData,
    );

    return prefixIcon;
  }

  /// This validator compute function is used for SelectField
  List<String? Function(dynamic)> computeFieldValidators(
    LayoutProps? layoutProps,
    Map<String, dynamic> contextData,
  ) {
    List<Map<String, dynamic>>? validatorsMap = layoutProps?.validators;
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

                  return FormBuilderValidators.max(
                    maxValue,
                    inclusive: inclusive,
                    errorText: errorText,
                  );

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

                  return FormBuilderValidators.min(
                    minValue,
                    inclusive: inclusive,
                    errorText: errorText,
                  );

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

                  return FormBuilderValidators.minLength(
                    minValue,
                    errorText: errorText,
                  );

                case "not_equal":
                  return FormBuilderValidators.notEqual(
                    validator["value"],
                    errorText: errorText,
                  );

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
    LayoutProps? layoutProps,
    Map<String, dynamic> contextData,
  ) {
    List<Map<String, dynamic>>? validatorsMap = layoutProps?.validators;
    List<String? Function(String?)> validators = validatorsMap != null
        ? validatorsMap
            .map((validator) {
              var errorText = validator["errorText"];
              switch (validator["type"]) {
                case "is_email":
                  return FormBuilderValidators.email(
                    errorText: errorText,
                  );
                case "numeric":
                  return FormBuilderValidators.numeric(
                    errorText: errorText,
                  );
                case "integer":
                  return FormBuilderValidators.integer(
                    errorText: errorText,
                  );
                case "date_string":
                  return FormBuilderValidators.dateString(
                    errorText: errorText,
                  );
                default:
                  return null;
              }
            })
            .where((validator) => validator != null)
            .cast<String? Function(String?)>()
            .toList()
        : [];

    var fieldValidators = computeFieldValidators(layoutProps, contextData);
    return [...validators, ...fieldValidators];
  }

  Future<String?> runValidationFunction({
    required TWidget thisWidget,
  }) async {
    String? validationFunction = thisWidget.widgetProps.validationFunction;
    if (validationFunction != null && validationFunction.isNotEmpty) {
      var errorMessage = await thisWidget.executeJSWithPagePath(
        validationFunction,
        [],
      );

      /**
       * errorMessage could return as Map with
       * key: field name
       * valute: error message
       */
      if (errorMessage is Map) {
        return errorMessage[thisWidget.widgetProps.name];
      }

      return errorMessage;
    }
    return null;
  }

  TextInputType getTextInputType(LayoutProps? layoutProps) {
    if (layoutProps?.fieldType == CurrencyFieldType ||
        layoutProps?.keyboardType == "number") {
      return TextInputType.number;
    }

    return TextInputType.text;
  }

  InputBorder? _computeInputBorder(LayoutProps props, BorderProps? rawBorder) {
    return props.boxBorder?.type == "none"
        ? InputBorder.none
        : ThemeDecoder.decodeInputBorder(rawBorder?.toJson());
  }
}
