import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TSizedBox extends TStatelessWidget {
  TSizedBox(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = snapshot;
    LayoutProps? _props = props;

    if (_props != null) {
      _snapshot = SizedBox(
        key: getBindingKey(),
        height: _props.height,
        width: _props.width,
        child: TWidgets(
          layout: _props.child!,
          pagePath: pagePath,
          childData: childData,
        ),
      );
    }

    return _snapshot;
  }
}
