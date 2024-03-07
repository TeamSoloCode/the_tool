import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TVisibility extends TStatelessWidget {
  TVisibility(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = props;

    if (_props != null) {
      var maintainAnimation = _props.maintainAnimation ?? false;
      var maintainState = _props.maintainState ?? false;
      if (_props.maintainSize == true) {
        maintainAnimation = true;
        maintainState = true;
      }

      snapshot = Visibility(
        key: getBindingKey(),
        visible: _props.visible ?? true,
        maintainSize: _props.maintainSize ?? false,
        maintainAnimation: maintainAnimation,
        maintainState: maintainState,
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
