import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart'
    show FormBuilderTextField;
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderValidators;
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class TTextField extends TWidget {
  TTextField({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<TTextField> createState() => _TTextFieldState();
}

Timer? _debounce;

class _TTextFieldState extends TStatefulWidget<TTextField> {
  final textFieldController = TextEditingController();
  String? value;
  var debounceDuration = const Duration(milliseconds: 500);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    String newText = widget.contextData[name] ?? "";
    String currentText = textFieldController.text;
    if (newText != currentText && name != null) {
      Future.delayed(Duration.zero, () async {
        textFieldController.value = TextEditingValue(
            text: newText,
            selection: TextSelection.fromPosition(
              TextPosition(offset: newText.length),
            ));
      });
    }

    super.didChangeDependencies();
  }

  void _debounceTextChanged(
    String? text,
    Map<String, dynamic> contextData,
  ) {
    String? name = widget.props?.name;
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(debounceDuration, () {
      String newText = contextData[name] ?? "";
      if (newText != text && name != null) {
        widget.setPageData({name: text});
      }
    });
  }

  Widget _computeTextField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    assert(name != null, "Missing \"name\" in field widget");

    return FormBuilderTextField(
      controller: textFieldController,
      name: name ?? "",
      decoration: const InputDecoration(
        hintText: "Placeholder",
        labelText: 'Required field number and below than 10',
      ),
      // initialValue: contextData[name] ?? "",
      onChanged: (text) {
        _debounceTextChanged(text, contextData);
      },
      onReset: () {
        textFieldController.value = TextEditingValue.empty;
        widget.setPageData({name!: ""});
      },
      onEditingComplete: () {
        log("onEditingComplete");
      },
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Required field"),
        FormBuilderValidators.numeric(errorText: "Number field"),
        FormBuilderValidators.max(10, errorText: "Must below than 10"),
      ]),
      keyboardType: TextInputType.text,
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeTextField(_props, widget.contextData);
    }

    return _snapshot;
  }
}
