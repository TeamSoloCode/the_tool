import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart'
    show FormBuilderTextField;
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderValidators;
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_TextField extends TWidget {
  T_TextField({
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
  State<T_TextField> createState() => _T_TextFieldState();
}

Timer? _debounce;

class _T_TextFieldState extends TStatefulWidget<T_TextField> {
  var textFieldController = TextEditingController();
  String? currentValue;
  var debounceDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    String? name = widget.widgetProps.name;
    assert(name != null, "Missing \"name\" in field widget");
    var text = widget.contextData[name] ?? "";
    textFieldController.text = text;
    currentValue = text;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    String currentText = textFieldController.text;
    currentValue = widget.contextData[name];
    if (currentValue != currentText && name != null) {
      Future.delayed(Duration.zero, () async {
        textFieldController.value = TextEditingValue(
            text: currentValue ?? "",
            selection: TextSelection.fromPosition(
              TextPosition(offset: currentValue?.length ?? 0),
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
        currentValue = text;
      }
    });
  }

  Widget _computeTextField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;

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
