import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TCard extends TStatelessWidget {
  TCard(TWidgetProps twidget) : super(twidget);

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = props;

    if (_props != null) {
      snapshot = Card(
        key: getBindingKey(),
        color: ThemeDecoder.decodeColor(_props.color),
        elevation: _props.elevation,
        shape: ThemeDecoder.decodeShapeBorder(
          _props.shapeBorder?.toJson(),
        ),
        margin: ThemeDecoder.decodeEdgeInsetsGeometry(_props.margin),
        shadowColor: ThemeDecoder.decodeColor(_props.shadowColor),
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
