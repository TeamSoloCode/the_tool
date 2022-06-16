import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/utils.dart';

class T_Block extends T_Widget {
  T_Block({
    Key? key,
    required executeJS,
    required widgetProps,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  @override
  State<T_Block> createState() => _T_BlockState();
}

class _T_BlockState extends State<T_Block> {
  @override
  Widget build(BuildContext context) {
    var path = widget.widgetProps["path"];
    return T_Page(pagePath: path);
  }
}
