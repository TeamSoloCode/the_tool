import 'dart:developer';

import 'package:form_builder_validators/form_builder_validators.dart';

mixin FieldMixin {
  List<String? Function(String?)> computeValidators(
    List<Map<String, dynamic>>? validatorsMap,
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

      if (validator["type"] == "is_email") {
        validators.add(
          FormBuilderValidators.email(errorText: validator["errorText"]),
        );
      }
    });

    return validators;
  }
}
