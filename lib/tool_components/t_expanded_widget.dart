import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_Expanded extends T_Widget {
  T_Expanded({
    Key? key,
    required widgetProps,
    required pagePath,
    required parentData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: parentData,
          pagePath: pagePath,
        );

  @override
  State<T_Expanded> createState() => _T_ExpandedState();
}

class _T_ExpandedState extends State<T_Expanded> {
  LayoutProps? _props;
  LayoutProps? _prevProps;
  Widget _snapshot = const SizedBox.shrink();

  Future<void> _computeProps(Map<String, dynamic> contextData) async {
    var nextProps = await widget.utils.computeWidgetProps(
      widget.widgetProps,
      contextData,
    );

    if (_props != nextProps) {
      setState(() {
        _props = nextProps;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.widgetProps.flex ?? 1,
      child: T_Widgets(
        layout: widget.widgetProps.child ?? const LayoutProps(),
        pagePath: widget.pagePath,
        contextData: widget.parentData,
      ),
    );
  }
}
