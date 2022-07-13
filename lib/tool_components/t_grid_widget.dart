import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_Grid extends T_Widget {
  UtilsManager utils = getIt<UtilsManager>();
  final String pagePath;
  T_Grid({
    Key? key,
    required executeJS,
    required widgetProps,
    required this.pagePath,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  @override
  State<T_Grid> createState() => _T_GridState();
}

class _T_GridState extends State<T_Grid> {
  List<Widget> _computeChildren(List<dynamic>? children) {
    return (children ?? []).map((child) {
      return T_Widgets(
        layout: child,
        pagePath: widget.pagePath,
        contextData: widget.contextData,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var items = _computeChildren(widget.widgetProps.children);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width,
        mainAxisExtent: 120,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext ctx, index) {
        return items.elementAt(index);
      },
    );
  }
}
