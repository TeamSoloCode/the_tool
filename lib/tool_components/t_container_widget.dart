import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/container_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/common_interfaces.dart';

class T_Container extends TStatelessWidget with ContainerMixin {
  T_Container(TWidgetProps twidget) : super(twidget);
  @override
  Widget buildWidget(BuildContext context) {
    snapshot = Container(
      key: getBindingKey(),
      alignment: computeAlignment(props),
      height: props?.height,
      width: props?.width,
      margin: ThemeDecoder.decodeEdgeInsetsGeometry(props?.margin),
      padding: ThemeDecoder.decodeEdgeInsetsGeometry(props?.padding),
      constraints: BoxConstraints(
        maxHeight: props?.maxHeight,
        maxWidth: props?.maxWidth,
        minHeight: props?.minHeight,
        minWidth: props?.minWidth,
      ),
      decoration: computeBoxDecoration(props),
      child: TWidgets(
        layout: props?.child ?? const LayoutProps(),
        pagePath: pagePath,
        childData: childData,
      ),
    );

    if (props?.scrollable == true) {
      snapshot = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: snapshot,
      );
    }

    return snapshot;
  }
}
