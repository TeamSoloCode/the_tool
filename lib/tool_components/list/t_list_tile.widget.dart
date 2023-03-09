import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/container_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TListTile extends TWidget with ContainerMixin {
  TListTile(TWidgetProps twidget) : super(twidget);

  @override
  State<TListTile> createState() => _TListTileState();
}

class _TListTileState extends TStatefulWidget<TListTile> {
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

  Widget? _computeListTileWidget(LayoutProps? content) {
    if (content == null) return const Offstage();
    return TWidgets(
      layout: content,
      pagePath: widget.pagePath,
      childData: widget.childData,
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = ListTile(
        key: widget.getBindingKey(),
        horizontalTitleGap: _props.horizontalTitleGap,
        leading: _computeListTileWidget(_props.leading),
        title: _computeListTileWidget(_props.title),
        subtitle: _computeListTileWidget(_props.subtitle),
        trailing: _computeListTileWidget(_props.trailing),
        onTap: _props.onClick == null ? null : _onClick,
        onLongPress: _props.onLongClick == null ? null : _onLongClick,
      );
    }

    return _snapshot;
  }
}
