import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_SelectField extends TWidget {
  T_SelectField({
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
  State<T_SelectField> createState() => _T_SelectFieldState();
}

class _T_SelectFieldState extends TStatefulWidget<T_SelectField> {
  String? selectedValue;
  final _dropDownKey = GlobalKey<FormBuilderFieldState>();
  dynamic items;
  String? _errorMessage = null;

  @override
  void initState() {
    if (widget.widgetProps.defaultValue != null) {
      _onChangeOption(widget.widgetProps.defaultValue);
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    dynamic currentValue = _dropDownKey.currentState?.value;
    selectedValue = widget.contextData[name];
    if (selectedValue != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _dropDownKey.currentState?.setValue(selectedValue);
        _dropDownKey.currentState?.setState(() {});
      });
    }

    super.didChangeDependencies();
  }

  List<DropdownMenuItem> _computeDropdownItems(dynamic items) {
    if (items is! List) return [];

    return items.map(
      (item) {
        var value = item is! List ? item : item[0];
        var label = item is! List ? item : item[1];
        return DropdownMenuItem(
          value: value,
          child: Text('$label'),
        );
      },
    ).toList();
  }

  void _onChangeOption(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    selectedValue = value;
  }

  Widget _computeSelectField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];
    items = widgetProps?.items ?? [];
    assert(name != null, "Missing \"name\" in field widget");

    /** "items" property might be a string, that's mean it's a databinding */
    if (items is String) {
      items = contextData[items] ?? [];
    }
    _dropDownKey.currentState?.setValue(value);
    return FormBuilderDropdown(
      key: _dropDownKey,
      name: name ?? "",
      decoration: InputDecoration(
        hintText: widgetProps?.hintText,
        labelText: widgetProps?.labelText,
        errorText: _errorMessage,
      ),
      onChanged: _onChangeOption,
      initialValue: widget.props?.defaultValue ?? value,
      allowClear: widget.props?.allowClear != null ? true : false,
      validator: FormBuilderValidators.compose([
        (dynamic value) {
          _runValidationFunction();
          return null;
        }
      ]),
      onSaved: (dynamic value) {
        _runValidationFunction();
      },
      items: _computeDropdownItems(items),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeSelectField(_props, widget.contextData);
    }
    return _snapshot;
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
}
