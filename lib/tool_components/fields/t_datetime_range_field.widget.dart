import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TDateTimeRangeField extends TWidget {
  TDateTimeRangeField(TWidgetProps twidget) : super(twidget);

  @override
  State<TDateTimeRangeField> createState() => _TDateTimeRangeState();
}

class _TDateTimeRangeState extends TStatefulWidget<TDateTimeRangeField>
    with FieldMixin {
  // final _datetimeKey = GlobalKey<FormBuilderFieldState>();

  Widget _computeDateTimeField(
    LayoutProps widgetProps,
    Map<String, dynamic> contextData,
  ) {
    return SfDateRangePicker(
        // key: _datetimeKey,
        );
    // return Text("TODO");
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = widget.props;

    if (_props != null) {
      snapshot = _computeDateTimeField(_props, widget.getContexData());
    }
    return snapshot;
  }
}
