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
  final textFieldController = TextEditingController();
  String? value;
  String? prevValue;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  void _debounceTextChanged(String? text) {
    String? name = widget.props?.name;
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 200), () {
      String newText = widget.parentData[name] ?? "";
      if (newText != text && name != null) {
        widget.setPageData({name: text});
        prevValue = text == "" ? null : text;
      }
    });
  }

  Widget _computeTextField(
    LayoutProps? widgetProps,
    BuildContext context,
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
      if (_props.hidden == true) {
        return const SizedBox.shrink();
      }

      _snapshot = _computeTextField(_props, context);
    }

    return _snapshot;
  }
}
