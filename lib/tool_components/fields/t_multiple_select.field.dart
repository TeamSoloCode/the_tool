import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TMultiSelectField extends TWidget {
  TMultiSelectField(TWidgetProps tWidget) : super(tWidget);

  @override
  TStatefulWidget<TMultiSelectField> createState() => _TMultiSelectFieldState();
}

class _TMultiSelectFieldState extends TStatefulWidget<TMultiSelectField>
    with FieldMixin {
  String? _errorMessage;
  List _selectedValues = [];

  final _dropdownSearchKey = GlobalKey<DropdownSearchState>();

  @override
  void initState() {
    _selectedValues = [];
    super.initState();
  }

  Widget _computeMultiSelectField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];

    assert(name != null, "Missing \"name\" in field widget");

    return FormBuilderField(
      name: name!,
      builder: (FormFieldState<Object> field) {
        return _multiSelect(widgetProps!, field, contextData, widgetProps);
      },
      enabled: widgetProps?.enabled ?? true,
      onChanged: _onChangeOption,
      initialValue: widget.props?.defaultValue ?? value,
      validator: FormBuilderValidators.compose([
        ...computeFieldValidators(widget.props, contextData),
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

  Widget _multiSelect(
    LayoutProps props,
    FormFieldState<Object> field,
    Map<String, dynamic> contextData,
    LayoutProps? widgetProps,
  ) {
    List items = props.items ?? [];
    List computedItems = [];

    if (items.isNotEmpty) {
      if (items[0] is List) {
        computedItems = items.map((e) => e[0]).toList();
      } else {
        computedItems = List<String>.from(items);
      }
    }

    return DropdownSearch.multiSelection(
      items: computedItems,
      selectedItems: _selectedValues,
      itemAsString: (item) {
        if (items[0] is List) {
          var rep = items.firstWhere(
            (element) => element[0] == item,
            orElse: () {
              String? name = widgetProps?.name;

              throw Exception(
                "Field \"$name\" has error: Selected item \"$item\" not exist in list dropdown!",
              );
            },
          );
          return rep[1];
        }

        return item.toString();
      },
      key: _dropdownSearchKey,
      onChanged: field.didChange,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: computeFieldDecoration(
          widgetProps,
          thisWidget: widget,
          errorMessage: field.errorText ?? _errorMessage,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    if (widget.getContexData()[name] is! List) {
      throw Exception(
          "Field \"$name\" has error: Selected items must be a List!");
    }
    List<dynamic>? listDataFromServer = widget.getContexData()[name];
    // Selected value để add vào multiSelected field không được là List<dynamic>
    _selectedValues = listDataFromServer!.cast<String>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dropdownSearchKey.currentState?.dispose();
    super.dispose();
  }

  void _onChangeOption(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    _selectedValues = value;
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
    if (widget.props != null) {
      snapshot = _computeMultiSelectField(
        widget.props,
        widget.getContexData(),
      );
    }
    return snapshot;
  }
}
