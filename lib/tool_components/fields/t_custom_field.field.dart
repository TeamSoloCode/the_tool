import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TCustomField extends TWidget {
  TCustomField(TWidgetProps twidget) : super(twidget);

  @override
  State<TCustomField> createState() => _TCustomFieldState();
}

class _TCustomFieldState extends TStatefulWidget<TCustomField> with FieldMixin {
  dynamic selectedValue;
  final _customFieldKey = GlobalKey<FormBuilderFieldState>();
  String? _errorMessage;

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
    dynamic currentValue = _customFieldKey.currentState?.value;
    selectedValue = widget.getContexData()[name];
    if (selectedValue != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _customFieldKey.currentState?.setValue(selectedValue);
        _customFieldKey.currentState?.setState(() {});
      });
    }

    super.didChangeDependencies();
  }

  void _onChangeOption(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    selectedValue = value;
  }

  Widget _computeCustomField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];
    assert(name != null, "Missing \"name\" in field widget");

    _customFieldKey.currentState?.setValue(value);

    return FormBuilderField(
      key: _customFieldKey,
      name: name ?? "",
      builder: (field) {
        var child = widgetProps?.child;
        if (child == null) return const SizedBox();

        return InputDecorator(
          decoration: computeFieldDecoration(
            widgetProps,
            thisWidget: widget,
            errorMessage: field.errorText ?? _errorMessage,
          ),
          child: TWidgets(
            layout: child,
            pagePath: widget.pagePath,
            childData: widget.childData,
          ),
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
  Widget buildWidget(BuildContext context) {
    if (widget.props != null) {
      snapshot = _computeCustomField(widget.props, widget.getContexData());
    }
    return snapshot;
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
