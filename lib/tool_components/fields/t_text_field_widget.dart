import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart'
    show FormBuilderTextField;
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderValidators;
import 'package:the_tool/page_utils/debouncer.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TTextField extends TWidget {
  TTextField(TWidgetProps twidget) : super(twidget);

  @override
  State<TTextField> createState() => _TTextFieldState();
}

class _TTextFieldState extends TStatefulWidget<TTextField> with FieldMixin {
  var textFieldController = TextEditingController();
  String? currentValue;
  String? _errorMessage;
  bool _isUserTying = false;

  final Debouncer _textChangedDebouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void initState() {
    String? name = widget.widgetProps.name;
    assert(name != null, "Missing \"name\" in field widget");
    var text = widget.getContexData()[name] ?? "";
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
    _isUserTying = true;

    _textChangedDebouncer.run(() {
      String newText = contextData[name] ?? "";
      if (newText != text && name != null) {
        widget.setPageData({name: text});
        currentValue = text;

        _isUserTying = false;
      }
    });
  }

  Widget _computeTextField(
    LayoutProps? computedProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = computedProps?.name;

    return FormBuilderTextField(
      controller: textFieldController,
      name: name ?? "",
      inputFormatters: [
        // FilteringTextInputFormatter.digitsOnly,
      ],
      enabled: computedProps?.enabled ?? true,
      decoration: computeFieldDecoration(
        computedProps,
        thisWidget: widget,
        errorMessage: _errorMessage,
      ),
      obscureText: UtilsManager.isTruthy(computedProps?.obscureText) ?? false,
      // initialValue: contextData[name] ?? "",
      onChanged: (text) {
        _debounceTextChanged(text, contextData);
      },
      onEditingComplete: () {
        log("onEditingComplete");
      },
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose([
        ...computeCommonValidators(widget.props, contextData),
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
    runValidationFunction(
      thisWidget: widget,
      onError: (errorMsg) {
        setState(() {
          _errorMessage = errorMsg;
        });
      },
    );
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
