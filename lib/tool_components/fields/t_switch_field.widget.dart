import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/custom_field_title.widget.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/twidget_props.dart';

class TSwitchField extends TWidget {
  TSwitchField(TWidgetProps twidget) : super(twidget);

  @override
  State<TSwitchField> createState() => _TSwitchState();
}

class _TSwitchState extends TStatefulWidget<TSwitchField> with FieldMixin {
  final _switchFieldKey = GlobalKey<FormBuilderFieldState>();
  String? _errorMessage;
  bool? selectedValue;

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    dynamic currentValue = _switchFieldKey.currentState?.value;

    selectedValue = UtilsManager.isTruthy(widget.getContexData()[name]);

    if (selectedValue != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _switchFieldKey.currentState?.setValue(selectedValue);
      });
    }

    super.didChangeDependencies();
  }

  void _onChangeValue(bool? value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    selectedValue = UtilsManager.isTruthy(value);
  }

  Widget _computeSwitchField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name] ??
        UtilsManager.isTruthy(widget.widgetProps.defaultValue);

    assert(name != null, "Missing \"name\" in field widget");

    return FormBuilderSwitch(
      key: _switchFieldKey,
      name: name ?? "",
      selected: UtilsManager.isTruthy(value),
      enabled: widgetProps?.enabled ?? true,
      subtitle: CustomTitle(
        child: UtilsManager.computeTWidgets(
          widgetProps?.subtitle ?? const LayoutProps(),
          pagePath: widget.pagePath,
          childData: widget.childData,
        )!,
      ),
      title: CustomTitle(
        child: UtilsManager.computeTWidgets(
          widgetProps?.title ?? const LayoutProps(),
          pagePath: widget.pagePath,
          childData: widget.childData,
        )!,
      ),
      decoration: computeFieldDecoration(
        widgetProps,
        thisWidget: widget,
        errorMessage: _errorMessage,
      ),
      initialValue: UtilsManager.isTruthy(value),
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
      onChanged: _onChangeValue,
    );
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
    LayoutProps? _props = widget.props;

    if (_props != null) {
      snapshot = _computeSwitchField(_props, widget.getContexData());
    }
    return snapshot;
  }
}
