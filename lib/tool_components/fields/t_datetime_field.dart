import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';

class T_Datetime extends TWidget {
  T_Datetime({
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
  State<T_Datetime> createState() => _T_DatetimeState();
}

class _T_DatetimeState extends TStatefulWidget<T_Datetime> with FieldMixin {
  final _datetimeKey = GlobalKey<FormBuilderFieldState>();
  String? _errorMessage;
  DateTime? selectedValue;

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
    selectedValue = widget.contextData[name];
    if (selectedValue != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _datetimeKey.currentState?.setValue(selectedValue);
        _datetimeKey.currentState?.setState(() {});
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

  Widget _computeDatetimeField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];

    assert(name != null, "Missing \"name\" in field widget");

    return FormBuilderDateTimePicker(
      key: _datetimeKey,
      // locale: Localizations.localeOf(context),
      decoration: computeFieldDecoration(
        widgetProps,
        errorMessage: _errorMessage,
      ),
      name: name ?? "",
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
      _snapshot = _computeDatetimeField(_props, widget.contextData);
    }
    return _snapshot;
  }
}
