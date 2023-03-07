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

class T_Datetime extends TWidget {
  T_Datetime(TWidgetProps twidget) : super(twidget);

  @override
  State<T_Datetime> createState() => _T_DatetimeState();
}

class _T_DatetimeState extends TStatefulWidget<T_Datetime> with FieldMixin {
  final _datetimeKey = GlobalKey<FormBuilderFieldState>();
  String? _errorMessage;
  DateTime? selectedValue;
  var _datetimeFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    dynamic currentValue = _datetimeKey.currentState?.value;
    try {
      selectedValue = widget.getContexData()[name] != null
          ? DateTime.parse(widget.getContexData()[name].toString())
          : null;
    } catch (e) {
      throw Exception(
        "Fail to parse ${widget.getContexData()[name].toString()}. Please use \"yyyy-MM-dd hh:mm:ss\" format",
      );
    }

    if (selectedValue.toString() != currentValue.toString() && name != null) {
      Future.delayed(Duration.zero, () async {
        _datetimeKey.currentState?.setValue(selectedValue);
        _datetimeFieldController.text = selectedValue != null
            ? DateFormat(DefaultDateFormat).format(selectedValue!)
            : "";
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

  Widget _computeDatetimeField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];

    assert(name != null, "Missing \"name\" in field widget");
    return FormBuilderDateTimePicker(
      key: _datetimeKey,
      controller: _datetimeFieldController,
      name: name ?? "",
      format: DateFormat(DefaultDateFormat),
      locale: Localizations.localeOf(context),
      decoration: computeFieldDecoration(
        widgetProps,
        errorMessage: _errorMessage,
        suffixIcon: _getSuffixIcon(),
      ),
      initialValue: DateTime.tryParse(
        (widget.props?.defaultValue ?? value).toString(),
      ),
      validator: FormBuilderValidators.compose([
        ...computeFieldValidators(widget.props?.validators, contextData),
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

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeDatetimeField(_props, widget.getContexData());
    }
    return _snapshot;
  }
}
