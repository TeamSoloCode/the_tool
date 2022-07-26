import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Grid extends T_Widget {
  T_Grid({
    Key? key,
    required widgetProps,
    required pagePath,
    required contextData,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_Grid> createState() => _T_GridState();
}

class _T_GridState extends State<T_Grid> {
  List<Widget> _items = [];

  List<Widget> _computeChildren(
    List<dynamic>? children,
    Map<String, dynamic> contextData,
  ) {
    return (children ?? []).map((child) {
      return T_Widgets(
        layout: child,
        pagePath: widget.pagePath,
        contextData: contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    widget.watchContextState(context);

    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;
    LayoutProps? _prevProps = widget.prevProps;

    if (_props != null) {
      if (_props == _prevProps) {
        return _snapshot;
      }

      if (_props.hidden == true) {
        return const SizedBox.shrink();
      }

      _prevProps = _props;
      _items = _computeChildren(_props.children, widget.contextData);
      _snapshot = GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width,
          mainAxisExtent: 200,
        ),
        itemCount: _items.length,
        itemBuilder: (BuildContext ctx, index) {
          return _items.elementAt(index);
        },
      );
    }

    return _snapshot;
  }
}
