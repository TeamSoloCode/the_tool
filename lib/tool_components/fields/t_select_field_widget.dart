import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

class T_SelectField extends T_Widget {
  T_SelectField({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
        );

  @override
  State<T_SelectField> createState() => _T_SelectFieldState();
}

class _T_SelectFieldState extends State<T_SelectField> {
  LayoutProps? prevWidgetProps;
  LayoutProps? widgetProps;
  String? selectedValue;

  dynamic value;
  dynamic prevValue;

  dynamic items;
  dynamic prevItems;

  bool shouldWidgetUpdate() {
    widgetProps = widget.widgetProps;
    String? name = widgetProps?.name;
    dynamic currentItems = widgetProps?.items ?? [];

    var selectedValueInContext = widget.parentData[name];
    if (currentItems is String) {
      currentItems = widget.parentData[currentItems] ?? [];
    }

    bool isSameItems = false;

    if (currentItems is List || currentItems == null) {
      isSameItems =
          const DeepCollectionEquality().equals(currentItems, prevItems);
    } else {
      assert(false, "Select field data should be List or null");
    }

    var shouldUpdate = (selectedValue != selectedValueInContext) ||
        !isSameItems ||
        !(selectedValueInContext == prevValue) ||
        !const DeepCollectionEquality().equals(
          prevWidgetProps,
          widgetProps,
        );

    return shouldUpdate;
  }

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
    String name = widgetProps?.name ?? "";
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

    prevWidgetProps = widgetProps;

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
  Widget build(BuildContext context) {
    return ShouldWidgetUpdate(
      key: widget.getBindingKey(),
      builder: (context) {
        return _computeSelectField(widget.widgetProps, context);
      },
      shouldWidgetUpdate: shouldWidgetUpdate(),
    );
  }
}
