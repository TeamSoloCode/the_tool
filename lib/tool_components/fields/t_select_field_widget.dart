import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';

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

  dynamic value;
  dynamic prevValue;

  dynamic items;
  dynamic prevItems;

  List<DropdownMenuItem> _computeDropdownItems(dynamic value) {
    if (value is! List) return [];

    return value
        .map(
          (gender) => DropdownMenuItem(
            value: gender,
            child: Text('$gender'),
          ),
        )
        .toList();
  }

  void _onChangeOption(dynamic value) {
    String name = widget.props?.name ?? "";
    widget.setPageData({name: value});
    selectedValue = value;
  }

  Widget _computeSelectField(
    LayoutProps? widgetProps,
    BuildContext context,
  ) {
    String? name = widgetProps?.name;
    value = widget.parentData[name];
    items = widgetProps?.items ?? [];
    assert(name != null, "Missing \"name\" in field widget");

    /** "items" property might be a string, that's mean it's a databinding */
    if (items is String) {
      items = widget.parentData[items] ?? [];
    }

    prevValue = value;
    prevItems = items;

    return FormBuilderDropdown(
      key: value != null ? Key(value) : null,
      name: name ?? "",
      decoration: const InputDecoration(
        labelText: 'Gender',
      ),
      onChanged: _onChangeOption,
      initialValue: value,
      allowClear: true,
      hint: const Text('Select Gender'),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
        ],
      ),
      items: _computeDropdownItems(items),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeSelectField(_props, context);
    }

    return _snapshot;
  }
}
