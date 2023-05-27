import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:flutter/rendering.dart';

class TCheckbox extends TWidget {
  TCheckbox(TWidgetProps twidget) : super(twidget);

  @override
  State<TCheckbox> createState() => _TCheckboxState();
}

class _TCheckboxState extends TStatefulWidget<TCheckbox> with FieldMixin {
  final _checkboxKey = GlobalKey<FormBuilderFieldState>();
  String? _errorMessage;
  bool? selectedValue;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  void didChangeDependencies() {
    String? name = widget.widgetProps.name;
    dynamic currentValue = _checkboxKey.currentState?.value;

    selectedValue = UtilsManager.isTruthy(widget.getContexData()[name]);

    if (selectedValue != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _checkboxKey.currentState?.setValue(selectedValue);
      });
    }

    super.didChangeDependencies();
  }

  void _onChangeValue(bool? value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    selectedValue = UtilsManager.isTruthy(value);
  }

  Widget _computeCheckboxField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];

    assert(name != null, "Missing \"name\" in field widget");

    return FormBuilderCheckbox(
      key: _checkboxKey,
      name: name ?? "",
      selected: UtilsManager.isTruthy(value),
      title: CustomTitle(
        child: TWidgets(
          layout: widgetProps?.title ?? const LayoutProps(),
          pagePath: widget.pagePath,
          childData: widget.childData,
        ),
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
    String? validationFunction = widget.widgetProps.validationFunction;
    if (validationFunction != null && validationFunction.isNotEmpty) {
      var errorMessage = await widget.executeJSWithPagePath(validationFunction);
      setState(() {
        _errorMessage = errorMessage;
      });
    }
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeCheckboxField(_props, widget.getContexData());
    }
    return _snapshot;
  }
}

class CustomTitle extends SingleChildRenderObjectWidget {
  final Widget child;

  const CustomTitle({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCustomTitle();
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderCustomTitle renderObject) {
    // Nothing to update for now
  }
}

class _RenderCustomTitle extends RenderShiftedBox {
  _RenderCustomTitle() : super(null);

  @override
  void performLayout() {
    child!.layout(constraints, parentUsesSize: true);
    size = child!.size;
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    if (child == null) {
      return 0;
    }

    final double? childBaseline = child!.getDistanceToActualBaseline(baseline);
    return childBaseline ?? 0;
  }
}
