import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/constants.dart';
import 'package:the_tool/page_utils/debouncer.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/custom_importers/currency_formatter.dart'
    deferred as currency_formatter;

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
  late Future<bool> _loadNecessaryBundle;
  final _fieldKey = GlobalKey<FormBuilderFieldState>();

  final Debouncer _textChangedDebouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void initState() {
    String? name = widget.widgetProps.name;
    assert(name != null, "Missing \"name\" in field widget");

    _loadNecessaryBundle = _loadDependencies();
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

    if (currentValue == null) {
      final defaultValue = widget.widgetProps.defaultValue;
      if (defaultValue != null) {
        Future.delayed(Duration.zero, () async {
          _debounceTextChanged(defaultValue.toString(), widget.getContexData());
        });
      }
    }

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

  List<TextInputFormatter> _computeInputFormatters(
    LayoutProps? computedProps,
  ) {
    Map<String, dynamic> rawFormatters = computedProps?.formatters ?? {};
    if (rawFormatters.isEmpty) {
      return [];
    }

    List<TextInputFormatter> formatters = [];
    var errorMessage = "";

    if (computedProps?.fieldType == "text") {
      if (rawFormatters["number"] == true) {
        formatters.add(FilteringTextInputFormatter.digitsOnly);
      }

      if (rawFormatters["negativeNumber"] == true) {
        if (formatters.length == 1) {
          formatters.removeAt(0);
        }
        formatters.add(FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')));
      }
    } else if (computedProps?.fieldType == CurrencyFieldType) {
      final decimalPlaces = rawFormatters["decimalPlaces"];
      if (decimalPlaces != null && decimalPlaces is! int) {
        errorMessage = "\"decimalPlaces\" property must be an integer";
      }

      final maxLength = rawFormatters["maxLength"];
      if (maxLength != null && maxLength is! int) {
        errorMessage = "\"maxLength\" property must be an integer";
      }

      var thousandSeparator = currency_formatter.ThousandSeparator.Comma;
      final rawThousandSeparator = rawFormatters["thousandSeparator"];
      if (rawThousandSeparator != null) {
        switch (rawThousandSeparator) {
          case "Comma":
            break;
          case 'Space':
            thousandSeparator = currency_formatter.ThousandSeparator.Space;
            break;
          case 'Period':
            thousandSeparator = currency_formatter.ThousandSeparator.Period;
            break;
          case 'None':
            break;
          case 'SpaceAndPeriodDecimalPlaces':
            thousandSeparator =
                currency_formatter.ThousandSeparator.SpaceAndPeriodMantissa;
            break;
          case 'SpaceAndCommaDecimalPlaces':
            thousandSeparator =
                currency_formatter.ThousandSeparator.SpaceAndCommaMantissa;
            break;
          default:
            errorMessage = "\"thousandSeparator\" property is not correct";
        }
      }

      if (errorMessage != "") {
        throw Exception(errorMessage);
      }

      var leadingSymbol = rawFormatters["leadingSymbol"] ?? "";
      var trailingSymbol = rawFormatters["trailingSymbol"] ?? "";

      var currencyFormatter = currency_formatter.CurrencyInputFormatter(
        mantissaLength: decimalPlaces,
        maxTextLength: maxLength,
        thousandSeparator: thousandSeparator,
        leadingSymbol: leadingSymbol.toString(),
        trailingSymbol: trailingSymbol.toString(),
        onValueChange: (value) {
          if (rawFormatters["onChange"] != null) {
            widget.executeJSWithPagePath(
              rawFormatters["onChange"],
              [value.toStringAsFixed(decimalPlaces)],
            );
          }
        },
        useSymbolPadding: rawFormatters["useSymbolPadding"] ?? false,
      );

      formatters.add(currencyFormatter);
    }

    // [
    // FilteringTextInputFormatter.allow(RegExp(r'^-?\d{0,5}')), // allow 5 digits
    // FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
    // FilteringTextInputFormatter.digitsOnly,
    // TextInputFormatter.withFunction((oldValue, newValue) => null),
    // ],

    return formatters;
  }

  Future<bool> _loadDependencies() async {
    if (widget.widgetProps.fieldType == CurrencyFieldType) {
      await currency_formatter.loadLibrary();
    }
    return true;
  }

  Widget _computeTextField(
    LayoutProps? computedProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = computedProps?.name;

    return FutureBuilder<bool>(
      future: _loadNecessaryBundle,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox();
        }

        return FormBuilderTextField(
          controller: textFieldController,
          key: _fieldKey,
          name: name ?? "",
          inputFormatters: _computeInputFormatters(computedProps),
          maxLines: computedProps?.maxLines ?? 1,
          minLines: computedProps?.minLines,
          enabled: computedProps?.enabled ?? true,
          decoration: computeFieldDecoration(
            computedProps,
            thisWidget: widget,
            errorMessage: _errorMessage,
          ),
          obscureText:
              UtilsManager.isTruthy(computedProps?.obscureText) ?? false,
          // initialValue: (defaultValue == null ? "" : defaultValue.toString()),
          onChanged: (text) {
            _debounceTextChanged(text, contextData);
          },
          onEditingComplete: () {
            log("onEditingComplete");
          },
          // valueTransformer: (text) {
          //   if (computedProps?.fieldType == "currency") {
          //     return num.tryParse(text ?? "");
          //   }
          //   return text;
          // },
          validator: FormBuilderValidators.compose([
            ...computeCommonValidators(widget.props, contextData),
            (value) {
              _runValidationFunction();
              return null;
            },
          ]),
          onSaved: (value) {
            _runValidationFunction();
          },
          keyboardType: getTextInputType(widget.props),
        );
      },
    );
  }

  void _runValidationFunction() async {
    setState(() {
      _errorMessage =
          "checking..."; // this to prevent form validate pass the field before it validated;
    });

    String? errorMessage = await runValidationFunction(thisWidget: widget);

    setState(() {
      _errorMessage = errorMessage;
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? props = widget.props;

    if (props != null) {
      snapshot = _computeTextField(props, widget.getContexData());
    }

    return snapshot;
  }
}
