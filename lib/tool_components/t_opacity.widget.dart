import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TOpacity extends TStatelessWidget {
  TOpacity(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = props;

    if (_props != null) {
      snapshot = Opacity(
        key: getBindingKey(),
        opacity: _props.opacity ?? 1.0,
        child: _props.child == null
            ? const Offstage()
            : TWidgets(
                layout: _props.child!,
                pagePath: pagePath,
                childData: childData,
              ),
      );
    }

    return snapshot;
  }
}
