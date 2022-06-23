import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart'
    show FormBuilderTextField;
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderValidators;
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_TextField extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();

  T_TextField({
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
  State<T_TextField> createState() => _T_TextFieldState();
}

Timer? _debounce;

class _T_TextFieldState extends State<T_TextField> {
  final textFieldController = TextEditingController();
  Map<String, dynamic> prevWidgetProps = {};
  Map<String, dynamic> widgetProps = {};
  String? value;
  String? prevValue;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  bool shouldWidgetUpdate() {
    widgetProps = widget.widgetProps;
    String? name = widgetProps["name"];
    String newText = widget.contextData[name] ?? "";

    if (prevValue != newText) {
      textFieldController.text = newText;
      textFieldController.selection = TextSelection.collapsed(
        offset: newText.length,
      );
    }

    var shouldUpdate = !const DeepCollectionEquality().equals(
      prevWidgetProps,
      widgetProps,
    );

    return shouldUpdate;
  }

  Widget _computeTextField(
    Map<String, dynamic>? widgetProps,
    BuildContext context,
  ) {
    String? name = widgetProps?["name"];
    assert(name != null, "Missing \"name\" in field widget");

    void _debounceTextChanged(String? text) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      _debounce = Timer(const Duration(milliseconds: 100), () {
        String newText = widget.contextData[name] ?? "";
        if (newText != text && name != null) {
          widget.setPageData({name: text});
          prevValue = text == "" ? null : text;
        }
      });
    }

    prevWidgetProps = widgetProps ?? {};

    return FormBuilderTextField(
      controller: textFieldController,
      name: name ?? "",
      decoration: const InputDecoration(
        hintText: "Placeholder",
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
  }

  @override
  Widget build(BuildContext context) {
    return ShouldWidgetUpdate(
      key: widget.getBindingKey(),
      builder: (context) {
        return _computeTextField(widget.widgetProps, context);
      },
      shouldWidgetUpdate: shouldWidgetUpdate(),
    );
  }
}
