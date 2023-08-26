import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TChipChoiceField extends TWidget {
  TChipChoiceField(TWidgetProps tWidget) : super(tWidget);

  @override
  TStatefulWidget<TChipChoiceField> createState() => _TMultiSelectFieldState();
}

class _TMultiSelectFieldState extends TStatefulWidget<TChipChoiceField>
    with FieldMixin {
  String? _errorMessage;

  final _chipchoiceFieldKey = GlobalKey<FormBuilderFieldDecorationState>();

  Widget _computeChipChoiceField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;

    List<FormBuilderChipOption<String>> options = [];

    if (widgetProps?.items != null && widgetProps?.items! is List) {
      if (!UtilsManager.isValueBinding(widget.widgetProps.items)) {
        for (int index = 0; index < widgetProps!.items!.length; index++) {
          var item = UtilsManager.get(widgetProps.items!, index.toString());
          if (UtilsManager.get(item, 'value') == null) {
            throw Exception(
                "Field \"$name\" has error: Missing \"value\" property at index $index in ${widget.widgetProps.items} ");
          }
          var value = UtilsManager.get(item, 'value');
          options.add(FormBuilderChipOption(
            value: value,
            child: UtilsManager.computeTWidgets(
              widgetProps.itemLayout,
              pagePath: widget.pagePath,
              childData: item,
            ),
          ));
        }
      } else {
        for (int index = 0; index < widgetProps!.items!.length; index++) {
          var item = UtilsManager.get(widgetProps.items!, index.toString());
          if (UtilsManager.get(item, 'value') == null) {
            throw Exception(
                "Field \"$name\" has error: Missing \"value\" property at index $index in ${widget.widgetProps.items} ");
          }
          var value = UtilsManager.get(item, 'value');

          options.add(FormBuilderChipOption(
            value: value,
            child: UtilsManager.computeTWidgets(
              widgetProps.itemLayout,
              pagePath: widget.pagePath,
              childData: {
                UtilsManager.dataPath:
                    "${UtilsManager.removeBindingString(widget.widgetProps.items).trim()}.$index"
              },
            ),
          ));
        }
      }
    }

    var initValue = widget.getContexData()[name];

    assert(name != null, "Missing \"name\" in choice chip widget");
    return FormBuilderChoiceChip<dynamic>(
      validator: FormBuilderValidators.compose([
        ...computeFieldValidators(widget.props, contextData),
        (dynamic value) {
          _runValidationFunction();
          return null;
        }
      ]),
      key: _chipchoiceFieldKey,
      autovalidateMode:
          ThemeDecoder.decodeAutovalidateMode(widgetProps!.autovalidateMode),
      decoration: computeFieldDecoration(
        widgetProps,
        thisWidget: widget,
        errorMessage: _errorMessage,
      ),
      selectedColor: ThemeDecoder.decodeColor(widgetProps.backgroundColor),
      initialValue: initValue,
      name: widgetProps.name!,
      options: options,
      onChanged: _onChanged,
    );
  }

  void _onChanged(dynamic val) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: val});
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    var choiceChipSelected = widget.getContexData()[name];

    if (choiceChipSelected != _chipchoiceFieldKey.currentState?.value &&
        (choiceChipSelected is List || choiceChipSelected is String)) {
      var value = choiceChipSelected is List
          ? choiceChipSelected[0]
          : choiceChipSelected;
      _chipchoiceFieldKey.currentState?.setValue(value);
      _chipchoiceFieldKey.currentState?.setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _chipchoiceFieldKey.currentState?.dispose();
    super.dispose();
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
      snapshot = _computeChipChoiceField(
        widget.props,
        widget.getContexData(),
      );
    }
    return snapshot;
  }
}
