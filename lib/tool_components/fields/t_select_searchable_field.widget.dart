import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TSearchableSelectField extends TWidget {
  TSearchableSelectField(TWidgetProps twidget) : super(twidget);

  @override
  State<TSearchableSelectField> createState() => _TSearchableSelectFieldState();
}

class _TSearchableSelectFieldState
    extends TStatefulWidget<TSearchableSelectField> with FieldMixin {
  String? _errorMessage;
  final _dropDownKey = GlobalKey<FormBuilderFieldState>();
  String? selectedValue;

  Map<dynamic, dynamic> _castOptionsToMap(dynamic items) {
    if (items is! List) return {};
    Map<dynamic, dynamic> result = {};

    for (var item in items) {
      var value = UtilsManager.computeOptionValue(item);
      var label = UtilsManager.computeOptionLabel(item);

      result[value] = label;
    }

    return result;
  }

  List<dynamic> _computeOptionValues(Map<dynamic, dynamic> mapOfOptions) {
    return List.from(mapOfOptions.keys);
  }

  String Function(dynamic)? _computeItemsLabel(
    Map<dynamic, dynamic> mapOfOptions,
  ) {
    String convertItemAsString(dynamic currentItem) {
      return mapOfOptions[currentItem];
    }

    return convertItemAsString;
  }

  void _onChangeDate(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    if (value == null) {
      widget.setPageData({name: null});
    } else {
      widget.setPageData({name: value.toString()});
    }

    selectedValue = value;
  }

  Widget _computeSelectField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var items = widgetProps?.items ?? [];
    assert(name != null, "Missing \"name\" in field widget");
    var value = contextData[name];

    if (items is! List) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    /** "items" property might be a string, that's mean it's a databinding */
    if (items is String) {
      items = contextData[items] ?? [];
    }

    var optionsMap = _castOptionsToMap(items);

    return DropdownSearch<dynamic>(
      key: _dropDownKey,
      filterFn: (value, filter) {
        var label = optionsMap[value].toString();
        return label.contains(filter);
      },
      compareFn: (value1, value2) {
        var label1 = optionsMap[value1].toString();
        var label2 = optionsMap[value2].toString();
        return label1 == label2;
      },
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        // disabledItemFn: (s) => s.startsWith('C'),
        // itemBuilder: _computeDropdownItems(widgetProps?.itemLayout, items),
        showSearchBox: true,

        searchDelay: Duration(milliseconds: widgetProps?.duration ?? 1000),
        searchFieldProps: TextFieldProps(
          decoration: commonInputDecoration,
        ),
      ),
      itemAsString: _computeItemsLabel(optionsMap),
      items: _computeOptionValues(optionsMap),
      selectedItem: widget.props?.defaultValue ?? value,
      onChanged: _onChangeDate,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: computeFieldDecoration(
          widgetProps,
          thisWidget: widget,
          errorMessage: _errorMessage,
          suffixIcon: _getSuffixIcon(),
        ),
      ),
      validator: FormBuilderValidators.compose([
        ...computeFieldValidators(widget.props, contextData),
        (dynamic value) {
          _runValidationFunction();
          return null;
        }
      ]),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (widget.props != null) {
      snapshot = _computeSelectField(widget.props, widget.getContexData());
    }
    return snapshot;
  }

  void _onChangeOption(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    selectedValue = value;
  }

  Widget? _getSuffixIcon() {
    if (UtilsManager.isTruthy(
      widget.props?.allowClear,
    )) {
      return IconButton(
        onPressed: () {
          _dropDownKey.currentState?.setValue(null);
          _onChangeOption(null);
        },
        icon: const Icon(
          Icons.close,
        ),
      );
    }

    return null;
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
}

var commonInputDecoration = const InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.grey,
      style: BorderStyle.solid,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.grey,
      style: BorderStyle.solid,
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.grey,
      style: BorderStyle.solid,
    ),
  ),
);
