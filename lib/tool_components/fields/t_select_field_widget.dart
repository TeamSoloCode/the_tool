import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:uuid/uuid.dart';

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

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    dynamic currentValue = _dropDownKey.currentState?.value;
    if (selectedValue != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _dropDownKey.currentState?.setValue(selectedValue);
      });
    }

    super.didChangeDependencies();
  }

  List<DropdownMenuItem> _computeDropdownItems(dynamic value) {
    if (value is! List) return [];

    return value
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text('$item'),
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

    debugPrint("T_SelectField $name $value");

    return FormBuilderDropdown(
      key: _dropDownKey,
      name: name ?? "",
      decoration: const InputDecoration(
        labelText: 'Gender',
      ),
      onChanged: _onChangeOption,
      initialValue: value,
      allowClear: true,
      hint: const Text('Select Gender'),
      onReset: () {
        _onChangeOption(null);
        _dropDownKey.currentState!.setValue(null);
      },
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
      _snapshot = _computeSelectField(_props, widget.contextData);
    }
    return _snapshot;
  }
}
