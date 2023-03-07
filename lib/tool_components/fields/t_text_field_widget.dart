import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart'
    show FormBuilderTextField;
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderValidators;
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class T_TextField extends TWidget {
  T_TextField(TWidgetProps twidget) : super(twidget);

  @override
  State<T_TextField> createState() => _T_TextFieldState();
}

Timer? _debounce;

class _T_TextFieldState extends TStatefulWidget<T_TextField> with FieldMixin {
  var textFieldController = TextEditingController();
  String? currentValue;
  var debounceDuration = const Duration(milliseconds: 500);
  bool _showObscureText = false;
  String? _errorMessage = null;
  bool _isUserTying = false;

  @override
  void initState() {
    String? name = widget.widgetProps.name;
    assert(name != null, "Missing \"name\" in field widget");
    var text = widget.getContexData()[name] ?? "";
    textFieldController.text = text;
    currentValue = text;
    _showObscureText = widget.widgetProps.obscureText ?? false;
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
    currentValue = widget.getContexData()[name];

    if (currentValue != currentText && name != null) {
      if (_isUserTying) {
        currentValue = currentText;
      }

      _isUserTying = false;
      Future.delayed(Duration.zero, () async {
        textFieldController.value = TextEditingValue(
            text: currentValue ?? "",
            selection: TextSelection.fromPosition(
              TextPosition(offset: currentValue?.length ?? 0),
            ));
      });
    }
    if (widget.widgetProps.autovalidate == true) {
      _runValidationFunction();
    }
    super.didChangeDependencies();
  }

  void _debounceTextChanged(
    String? text,
    Map<String, dynamic> contextData,
  ) {
    String? name = widget.props?.name;
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _isUserTying = true;
    _debounce = Timer(debounceDuration, () {
      String newText = contextData[name] ?? "";
      if (newText != text && name != null) {
        widget.setPageData({name: text});
        currentValue = text;
      }
    });
  }

  Widget? _generateSuffixIcon(LayoutProps? widgetProps) {
    if (widgetProps?.obscureText == true) {
      return IconButton(
        icon: Icon(_showObscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            _showObscureText = !_showObscureText;
          });
        },
      );
    }

    return null;
  }

  Widget _computeTextField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    return FormBuilderTextField(
      controller: textFieldController,
      name: name ?? "",
      inputFormatters: [
        // FilteringTextInputFormatter.digitsOnly,
      ],

      decoration: computeFieldDecoration(
        widgetProps,
        suffixIcon: _generateSuffixIcon(widgetProps),
        errorMessage: _errorMessage,
      ),
      obscureText: _showObscureText,
      // initialValue: contextData[name] ?? "",
      onChanged: (text) {
        _debounceTextChanged(text, contextData);
      },
      onEditingComplete: () {
        log("onEditingComplete");
      },
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose([
        ...computeCommonValidators(widget.props?.validators, contextData),
        (value) {
          _runValidationFunction();
          return null;
        }
      ]),
      onSaved: (value) {
        _runValidationFunction();
      },
      keyboardType: _getTextInputType(widget.props),
    );
  }

  void _runValidationFunction() async {
    String? validationFunction = widget.widgetProps.validationFunction;
    if (validationFunction != null && validationFunction.isNotEmpty) {
      var errorMessage = await widget.executeJSWithPagePath(validationFunction);
      setState(() {
        _errorMessage = errorMessage;
      });
    }
    return null;
  }

  TextInputType _getTextInputType(LayoutProps? layoutProps) {
    if (layoutProps?.numeric == true) {
      return TextInputType.number;
    }

    return TextInputType.text;
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeTextField(_props, widget.getContexData());
    }

    return _snapshot;
  }
}
