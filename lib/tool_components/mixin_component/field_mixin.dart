import 'dart:developer';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/utils.dart';

mixin FieldMixin {
  final UtilsManager _utils = UtilsManager();

  List<String? Function(String?)> computeValidators(
    List<Map<String, dynamic>>? validatorsMap,
    Map<String, dynamic> contextData,
  ) {
    List<String? Function(String?)> validators = [];
    validatorsMap?.forEach((validator) {
      if (validator["type"] == "is_required") {
        validators.add(
          FormBuilderValidators.required(errorText: validator["errorText"]),
        );
      }

      if (validator["type"] == "is_email") {
        validators.add(
          FormBuilderValidators.email(errorText: validator["errorText"]),
        );
      }

      if (validator["type"] == "numeric") {
        validators.add(
          FormBuilderValidators.numeric(
            errorText: validator["errorText"],
          ),
        );
      }

      if (validator["type"] == "max") {
        dynamic maxValue;

        if (UtilsManager.isValueBinding(validator["maxValue"].toString())) {
          maxValue = _utils.bindingValueToProp(
            contextData,
            validator["maxValue"],
          );
          maxValue = double.tryParse(maxValue.toString());
        } else {
          maxValue = double.tryParse(validator["maxValue"].toString());
        }

        if (maxValue == null) {
          throw Exception("maxValue of max validator must be a number");
        }

        var inclusive = UtilsManager.isTruthy(validator["inclusive"]);

        validators.add(
          FormBuilderValidators.max(
            maxValue,
            inclusive: inclusive,
            errorText: validator["errorText"],
          ),
        );
      }

      if (validator["type"] == "min") {
        dynamic minValue;
        if (UtilsManager.isValueBinding(validator["maxValue"].toString())) {
          minValue = _utils.bindingValueToProp(
            contextData,
            validator["maxValue"],
          );
          minValue = double.tryParse(minValue.toString());
        } else {
          minValue = double.tryParse(validator["minValue"].toString());
        }

        if (minValue == null) {
          throw Exception("minValue of min validator must be a number");
        }

        var inclusive = UtilsManager.isTruthy(validator["inclusive"]);

        validators.add(
          FormBuilderValidators.min(
            minValue,
            inclusive: inclusive,
            errorText: validator["errorText"],
          ),
        );
      }

      if (validator["type"] == "max_length") {
        var maxValue = int.tryParse(validator["maxLengthValue"].toString());

        if (maxValue == null) {
          throw Exception("maxLengthValue of min validator must be a number");
        }

        validators.add(
          FormBuilderValidators.maxLength(
            maxValue,
            errorText: validator["errorText"],
          ),
        );
      }

      if (validator["type"] == "min_length") {
        var minValue = int.tryParse(validator["minLengthValue"].toString());

        if (minValue == null) {
          throw Exception("minLengthValue of min validator must be a number");
        }

        validators.add(
          FormBuilderValidators.minLength(
            minValue,
            errorText: validator["errorText"],
          ),
        );
      }
    });

    return validators;
  }
}
