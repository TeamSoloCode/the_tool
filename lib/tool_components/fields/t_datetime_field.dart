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
  String? _errorMessage = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
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
