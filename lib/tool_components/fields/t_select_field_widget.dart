import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

class T_SelectField extends T_Widget {
  T_SelectField({
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
  State<T_SelectField> createState() => _T_SelectFieldState();
}

class _T_SelectFieldState extends State<T_SelectField> {
  Map<String, dynamic> prevWidgetProps = {};
  Map<String, dynamic> widgetProps = {};
  String? value;
  String? prevValue;

  bool shouldWidgetUpdate() {
    widgetProps = widget.widgetProps;
    String? name = widgetProps["name"];

    value = widget.contextData[name] ?? "";
    bool isSameValue = false;

    if (value is Map) {
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

  Widget _computeSelectField(
    Map<String, dynamic>? widgetProps,
    BuildContext context,
  ) {
    prevValue = value;

    return FormBuilderDropdown(
      name: 'gender',
      decoration: const InputDecoration(
        labelText: 'Gender',
      ),
      initialValue: 'male',
      allowClear: true,
      hint: const Text('Select Gender'),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
        ],
      ),
      items: ["male", "female", "gay"]
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text('$gender'),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShouldWidgetUpdate(
      key: widget.getBindingKey(),
      builder: (context) {
        return _computeSelectField(widget.widgetProps, context);
      },
      shouldWidgetUpdate: shouldWidgetUpdate(),
    );
  }
}
