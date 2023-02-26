import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/container_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Clickable extends TWidget {
  T_Clickable({
    Key? key,
    required widgetUuid,
    required widgetProps,
    required pagePath,
    childData = const {},
  }) : super(
          key: key,
          childData: childData,
          widgetUuid: widgetUuid,
          pagePath: pagePath,
          widgetProps: widgetProps,
        );

  @override
  State<T_Clickable> createState() => _T_Clickable();
}

class _T_Clickable extends TStatefulWidget<T_Clickable> with ContainerMixin {
  void _onClick() async {
    var rawOnClick = widget.props?.onClick;
    if (rawOnClick is String) {
      await widget.executeJSWithPagePath(rawOnClick);
    }
  }

  void _onLongClick() async {
    var rawOnLongClick = widget.props?.onLongClick;
    if (rawOnLongClick is String) {
      await widget.executeJSWithPagePath(rawOnLongClick);
    }
  }

  Widget _computeClickable(LayoutProps? props) {
    var onLongClick = widget.props?.onLongClick;

    var computedChild = props?.child == null
        ? null
        : Ink(
            key: widget.getBindingKey(),
            // color: ThemeDecoder.decodeColor(props?.backgroundColor),
            decoration: computeBoxDecoration(props),
            height: props?.height,
            width: props?.width,
            padding: ThemeDecoder.decodeEdgeInsetsGeometry(props?.padding),
            child: TWidgets(
              layout: props!.child!,
              pagePath: widget.pagePath,
              childData: widget.childData,
            ),
          );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: widget.getBindingKey(),
        radius: props?.radius,
        onTap: _onClick,
        onLongPress: onLongClick != null ? _onLongClick : null,
        splashColor: ThemeDecoder.decodeColor(props?.splashColor),
        child: computedChild,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return _computeClickable(widget.props);
  }
}
