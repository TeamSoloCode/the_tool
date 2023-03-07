import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/tool_components/mixin_component/container_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class T_Avatar extends TWidget with ContainerMixin {
  T_Avatar(TWidgetProps twidget) : super(twidget);

  @override
  State<T_Avatar> createState() => _T_AvatarState();
}

class _T_AvatarState extends TStatefulWidget<T_Avatar> {
  @override
  Widget buildWidget(BuildContext context) {
    return CircleAvatar(
      radius: widget.props?.radius,
      key: widget.getBindingKey(),
      backgroundColor: ThemeDecoder.decodeColor(widget.props?.backgroundColor),
      backgroundImage: ThemeDecoder.decodeImageProvider(widget.props?.image),
    );
  }
}
