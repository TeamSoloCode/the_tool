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

  Widget _computeSelectField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    return DropdownSearch(
      key: _dropDownKey,
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
