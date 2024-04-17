import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TFittedBox extends TStatelessWidget {
  TFittedBox(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    snapshot = FittedBox(
      key: getBindingKey(),
      fit: ThemeDecoder.decodeBoxFit(props?.fit) ?? BoxFit.contain,
      alignment:
          ThemeDecoder.decodeAlignment(props?.alignment) ?? Alignment.center,
      clipBehavior: ThemeDecoder.decodeClip(props?.clipBehavior) ?? Clip.none,
      child: TWidgets(
        layout: props?.child ?? const LayoutProps(),
        pagePath: pagePath,
        childData: childData,
      ),
    );

    return snapshot;
  }
}
