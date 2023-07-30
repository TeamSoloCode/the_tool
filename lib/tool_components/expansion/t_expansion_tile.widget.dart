import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/twidget_props.dart';

class TExpansionTitle extends TWidget {
  TExpansionTitle(TWidgetProps twidget) : super(twidget) {
    if (twidget.widgetProps.title == null) {
      throw Exception("Expansion Title mus have title property");
    }
  }

  @override
  State<TExpansionTitle> createState() => _TExapnsionTitle();
}

class _TExapnsionTitle extends TStatefulWidget<TExpansionTitle> {
  var _expanded = false;
  final GlobalKey<ExpansionTileCardState> expansionKey = GlobalKey();

  @override
  void initState() {
    _updateStateBaseOnContextData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _updateStateBaseOnContextData();
    super.didChangeDependencies();
  }

  Widget? _computeListTileWidget(LayoutProps? content) {
    if (content == null) return const Offstage();
    return TWidgets(
      layout: content,
      pagePath: widget.pagePath,
      childData: widget.childData,
    );
  }

  List<Widget> _computeExpansionTitleChildren(List<LayoutProps>? children) {
    if (children == null) return [];
    int index = 0;
    return children.map((child) {
      return TWidgets(
        key: ValueKey(++index),
        layout: child,
        pagePath: widget.pagePath,
        childData: widget.childData,
      );
    }).toList();
  }

  void _updateStateBaseOnContextData() {
    final name = widget.widgetProps.name;

    if (name != null) {
      var data = widget.getContexData()[name];
      if (data != null && data != _expanded) {
        setState(() {
          _expanded = data;
          if (data == true) {
            expansionKey.currentState?.expand();
          } else {
            expansionKey.currentState?.collapse();
          }
        });
      }
    }
  }

  void _onExpansionChanged(bool expanded) {
    setState(() {
      _expanded = expanded;
      var name = widget.widgetProps.name;

      if (name != null) {
        widget.setPageData({name: expanded});
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? _props = widget.props;
    if (_props != null) {
      snapshot = ExpansionTileCard(
        key: expansionKey,
        initiallyExpanded: _expanded,
        // TODO: Implement me
        // borderRadius: BorderRadius.all(ThemeDecoder.decodeRadius(_props.radius)),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        borderRadius: const BorderRadius.all(Radius.circular(0.0)),
        baseColor: ThemeDecoder.decodeColor(_props.backgroundColor),
        finalPadding: const EdgeInsets.only(bottom: 0),
        elevation: _props.elevation ?? 2.0,
        onExpansionChanged: _onExpansionChanged,
        leading: _computeListTileWidget(_props.leading),
        title: _computeListTileWidget(_props.title)!,
        subtitle: _computeListTileWidget(_props.subtitle),
        trailing: _computeListTileWidget(_props.trailing),

        children: _computeExpansionTitleChildren(_props.children),
      );
    }

    return snapshot;
  }
}
