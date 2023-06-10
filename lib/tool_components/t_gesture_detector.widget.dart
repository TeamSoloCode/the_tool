import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TGestureDetector extends TStatelessWidget {
  TGestureDetector(TWidgetProps twidget) : super(twidget);

  void _onTap() {
    final onClick = widgetProps.onClick;
    if (onClick == null) return;

    executeJSWithPagePath(onClick, []);
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = props;

    if (_props != null) {
      snapshot = GestureDetector(
        key: getBindingKey(),
        onTap: _onTap,
        child: TWidgets(
          layout: _props.child!,
          pagePath: pagePath,
          childData: childData,
        ),
      );
    }

    return snapshot;
  }
}
