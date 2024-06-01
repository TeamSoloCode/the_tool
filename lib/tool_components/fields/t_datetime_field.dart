import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/constants.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/twidget_props.dart';

class TDatetimeField extends TWidget {
  TDatetimeField(TWidgetProps twidget) : super(twidget);

  @override
  State<TDatetimeField> createState() => _TDatetimeState();
}

class _TDatetimeState extends TStatefulWidget<TDatetimeField> with FieldMixin {
  final _datetimeKey = GlobalKey<FormBuilderFieldState>();
  String? _errorMessage;
  DateTime? selectedValue;
  final _datetimeFieldController = TextEditingController();
  late DateFormat _formator;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    _formator = DateFormat(_getDefaultFormat(
      widget.widgetProps.fieldType,
      widget.widgetProps.format,
    ));
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    dynamic currentValue = _datetimeKey.currentState?.value;
    try {
      selectedValue =
          DateTime.tryParse(widget.getContexData()[name].toString());
    } catch (e) {
      throw Exception(
        "Fail to parse ${widget.getContexData()[name].toString()}. Please use \"yyyy-MM-dd hh:mm:ss\" format",
      );
    }

    if (selectedValue.toString() != currentValue.toString() && name != null) {
      Future.delayed(Duration.zero, () async {
        _datetimeKey.currentState?.setValue(selectedValue);
        _datetimeFieldController.text =
            selectedValue != null ? _formator.format(selectedValue!) : "";
      });
    }

    super.didChangeDependencies();
  }

  void _onChangeDate(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    if (value is DateTime) {
      widget.setPageData({name: value.toString()});
    } else if (value == null) {
      widget.setPageData({name: null});
    }

    selectedValue = value;
  }

  Widget? _getSuffixIcon() {
    if (UtilsManager.isTruthy(
      widget.props?.allowClear,
    )) {
      return IconButton(
        onPressed: () {
          _datetimeKey.currentState?.setValue(null);
          _datetimeFieldController.text = "";
          _onChangeDate(null);
        },
        icon: const Icon(
          Icons.close,
        ),
      );
    }

    return null;
  }

  InputType _getInputType(String? fieldType) {
    switch (fieldType) {
      case "date":
        return InputType.date;
      case "time":
        return InputType.time;
      default:
        return InputType.both;
    }
  }

  String _getDefaultFormat(String? fieldType, String? format) {
    if (format != null) {
      return format;
    }

    switch (fieldType) {
      case "date":
        return DefaultDateFormat;
      case "time":
        return DefaultTimeFormat;
      default:
        return DefaultDateTimeFormat;
    }
  }

  Widget _computeDatetimeField(
    LayoutProps props,
    Map<String, dynamic> contextData,
  ) {
    String? name = props.name;
    assert(name != null, "Missing \"name\" in field widget");

    var value = contextData[name];

    var lastDate = DateTime.tryParse(props.lastDate ?? "");
    var firstDate = DateTime.tryParse(props.firstDate ?? "");

    if (lastDate != null && firstDate != null && lastDate.isBefore(firstDate)) {
      throw Exception("lastDate must be after firstDate");
    }

    var selectedValue = _validateWithLastDateAndFirstDate(
      (props.defaultValue ?? value).toString(),
      firstDate: firstDate,
      lastDate: lastDate,
      errorValueName: "datefield value",
    );

    var initialDate = _validateWithLastDateAndFirstDate(
      props.initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      errorValueName: "initialDate",
    );

    return FormBuilderDateTimePicker(
      key: _datetimeKey,
      controller: _datetimeFieldController,
      name: name ?? "",
      lastDate: lastDate,
      firstDate: firstDate,
      initialDate: initialDate,
      inputType: _getInputType(props.fieldType),
      format: _formator,
      locale: Localizations.localeOf(context),
      enabled: props.enabled ?? true,
      decoration: computeFieldDecoration(
        props,
        thisWidget: widget,
        errorMessage: _errorMessage,
        suffixIcon: _getSuffixIcon(),
      ),
      initialValue: selectedValue,
      validator: FormBuilderValidators.compose([
        ...computeFieldValidators(props, contextData),
        (dynamic value) {
          _runValidationFunction();
          return null;
        }
      ]),
      onSaved: (dynamic value) {
        _runValidationFunction();
      },
      onChanged: _onChangeDate,
    );
  }

  DateTime? _validateWithLastDateAndFirstDate(
    String? value, {
    required DateTime? firstDate,
    required DateTime? lastDate,
    required String errorValueName,
  }) {
    DateTime? selectedDate;
    if (value == 'today') {
      selectedDate = DateTime.now();
    } else {
      selectedDate = DateTime.tryParse(value ?? "") ?? lastDate;
    }

    if (selectedDate != null) {
      if (lastDate != null && selectedDate.isAfter(lastDate)) {
        throw Exception(
            "$errorValueName must be before or equal to lastDate.\nDate: ${selectedDate.toString()}.\nLast date: ${lastDate.toString()}.");
      }

      if (firstDate != null && selectedDate.isBefore(firstDate)) {
        throw Exception(
            "$errorValueName must be after or equal to firstDate.\nDate: ${selectedDate.toString()}\nFirst date: ${lastDate.toString()}");
      }
    }

    return selectedDate;
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
    LayoutProps? _props = widget.props;

    if (_props != null) {
      snapshot = _computeDatetimeField(_props, widget.getContexData());
    }
    return snapshot;
  }
}
