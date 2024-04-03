import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/twidget_props.dart';

class TSelectField extends TWidget {
  TSelectField(TWidgetProps twidget) : super(twidget);

  @override
  State<TSelectField> createState() => _TSelectFieldState();
}

class _TSelectFieldState extends TStatefulWidget<TSelectField> with FieldMixin {
  String? selectedValue;
  final _dropDownKey = GlobalKey<FormBuilderFieldState>();
  dynamic items;
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
    dynamic currentValue = _dropDownKey.currentState?.value;
    selectedValue = widget.getContexData()[name];
    if (selectedValue != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        _dropDownKey.currentState?.setValue(selectedValue);
        _dropDownKey.currentState?.setState(() {});
      });
    }

    super.didChangeDependencies();
  }

  List<DropdownMenuItem> _computeDropdownItems(
      LayoutProps? itemLayout, dynamic items) {
    if (items is! List) return [];
    return items.map(
      (item) {
        var value = item is! List ? item : item[0];
        var label = item is! List ? item : item[1];
        return DropdownMenuItem(
          value: value,
          child: itemLayout == null
              ? Text('$label')
              : UtilsManager.computeTWidgets(
                  itemLayout,
                  pagePath: widget.pagePath,
                  childData: widget.childData,
                )!,
        );
      },
    ).toList();
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

  Widget _computeSelectField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];
    items = widgetProps?.items ?? [];
    assert(name != null, "Missing \"name\" in field widget");

    if (items is! List) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    /** "items" property might be a string, that's mean it's a databinding */
    if (items is String) {
      items = contextData[items] ?? [];
    }

    return FormBuilderDropdown(
      key: _dropDownKey,
      name: name ?? "",
      style: ThemeDecoder.decodeTextStyle(widgetProps?.style),
      icon: widgetProps?.icon == null
          ? null
          : UtilsManager.computeTWidgets(
              LayoutProps.fromJson(widgetProps?.icon),
              pagePath: widget.pagePath,
              childData: widget.childData,
            ),
      decoration: computeFieldDecoration(
        widgetProps,
        thisWidget: widget,
        errorMessage: _errorMessage,
        suffixIcon: _getSuffixIcon(),
      ),
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
      items: _computeDropdownItems(widgetProps?.itemLayout, items),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (widget.props != null) {
      snapshot = _computeSelectField(widget.props, widget.getContexData());
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
