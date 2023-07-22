import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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

class _TMultiSelectFieldState extends TStatefulWidget<TMultiSelectField> with FieldMixin{

  String? _errorMessage = null;
  List<dynamic>? selectedValues;
  final _dropdownSearchKey = GlobalKey<FormFieldState>();

  Widget _computeMultiSelectField(
      LayoutProps? widgetProps,
      Map<String, dynamic> contextData,
      ){

    String? name = widgetProps?.name;
    var value = contextData[name];
    // items = widgetProps?.items ?? [];
    assert(name != null, "Missing \"name\" in field widget");

    // _dropDownKey.currentState?.setValue(value);
    return  FormBuilderField(
      name: name!,

      builder: (FormFieldState<dynamic> field) {
      return   DropdownSearch<String>.multiSelection(
          key: _dropdownSearchKey,
          items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
          popupProps: PopupPropsMultiSelection.menu(
            showSelectedItems: true,
            disabledItemFn: (String s) => s.startsWith('I'),
          ),

          onChanged: (List<String> value) {
            field.didChange(value);
          },
          selectedItems: [],
        );
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


  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    dynamic currentValue = _dropdownSearchKey.currentState?.value;

    selectedValues = widget.getContexData()[name];
    if (selectedValues != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _dropdownSearchKey.currentState?.setValue(selectedValues);
        _dropdownSearchKey.currentState?.setState(() {});
      });
    }

    super.didChangeDependencies();
  }
  void _onChangeOption(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    selectedValues = value;
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
    LayoutProps? props = widget.props;

    if (props != null) {
      widget.snapshot = _computeMultiSelectField(props, widget.getContexData());
    }
    return widget.snapshot;
  }
}
