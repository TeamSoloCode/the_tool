import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/container_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/utils.dart';

class TListTile extends TWidget with ContainerMixin {
  TListTile(TWidgetProps twidget) : super(twidget);

  @override
  State<TListTile> createState() => _TListTileState();
}

class _TListTileState extends TStatefulWidget<TListTile> {
  void _onClick() async {
    var rawOnClick = widget.props?.onClick;
    if (rawOnClick is String) {
      await widget.executeJSWithPagePath(rawOnClick, []);
    }
  }

  void _onLongClick() async {
    var rawOnLongClick = widget.props?.onLongClick;
    if (rawOnLongClick is String) {
      await widget.executeJSWithPagePath(rawOnLongClick, []);
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? props = widget.props;

    if (props != null) {
      snapshot = ListTile(
        key: widget.getBindingKey(),
        horizontalTitleGap: props.horizontalTitleGap,
        dense: true,
        leading: UtilsManager.computeTWidgets(
          props.leading,
          pagePath: widget.pagePath,
          childData: widget.childData,
        ),
        title: UtilsManager.computeTWidgets(
          props.title,
          pagePath: widget.pagePath,
          childData: widget.childData,
        ),
        subtitle: UtilsManager.computeTWidgets(
          props.subtitle,
          pagePath: widget.pagePath,
          childData: widget.childData,
        ),
        trailing: UtilsManager.computeTWidgets(
          props.trailing,
          pagePath: widget.pagePath,
          childData: widget.childData,
        ),
        onTap: props.onClick == null ? null : _onClick,
        onLongPress: props.onLongClick == null ? null : _onLongClick,
      );
    }

    return snapshot;
  }
}
