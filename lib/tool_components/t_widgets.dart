import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/page_context_provider.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_fields_widget.dart';
import 'package:the_tool/tool_components/fields/t_form_widget.dart';
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:the_tool/tool_components/t_component_widget.dart';
import 'package:the_tool/tool_components/t_expanded_widget.dart';
import 'package:the_tool/tool_components/t_grid_widget.dart';
import 'package:the_tool/tool_components/t_icon_widget.dart';
import 'package:the_tool/tool_components/t_row_widget.dart';
import 'package:the_tool/tool_components/t_scrollview_widget.dart';
import 'package:the_tool/tool_components/t_text_widget.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:uuid/uuid.dart';

class T_Widgets extends StatefulWidget {
  final LayoutProps layout;
  final String pagePath;
  Map<String, dynamic> contextData;

  T_Widgets({
    Key? key,
    required this.layout,
    required this.pagePath,
    required this.contextData,
  }) : super(key: key);

  @override
  State<T_Widgets> createState() => _T_WidgetsState();
}

class _T_WidgetsState extends State<T_Widgets> {
  Widget? tWidgets;
  final widgetUuid = const Uuid().v4();

  Widget _getWidget(Map<String, dynamic> contextData) {
    LayoutProps content = widget.layout.content ?? widget.layout;

    if (tWidgets != null) {
      return tWidgets ?? const SizedBox.shrink();
    }

    debugPrint("abcd ${content.type}");

    switch (content.type) {
      case "text":
        return T_Text(
          key: Key(widgetUuid),
          widgetProps: content,
          contextData: contextData,
          pagePath: widget.pagePath,
        );
      case "button":
        return T_Button(
          key: ValueKey(widgetUuid),
          widgetUuid: widgetUuid,
          widgetProps: content,
          contextData: contextData,
          pagePath: widget.pagePath,
        );
      case "icon":
        return T_Icon(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          contextData: contextData,
          pagePath: widget.pagePath,
        );
      case "row":
        return T_Row(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "form":
      // return T_Form(
      //   key: ValueKey(widgetUuid),
      //   widgetProps: widgetProps,
      //   pagePath: widget.pagePath,
      //   contextData: contextData,
      // );
      case "component":
        return T_Component(
            key: ValueKey(widgetUuid),
            widgetProps: content,
            contextData: contextData,
            pagePath: widget.pagePath);
      case "container":
        return T_Container(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "column":
        return T_Column(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "grid":
        return T_Grid(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
        );
      case "scroll_view":
        return T_ScrollView(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
        );

      case "expanded":
        return T_Expanded(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          parentData: contextData,
        );
      case "field":
      // return T_Fields(
      //   key: ValueKey(widgetUuid),
      //   widgetProps: widgetProps,
      //   pagePath: widget.pagePath,
      //   contextData: contextData,
      // );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _updateTWidgets(
    BuildContext context,
  ) async {
    var contextData = context.read<ContextStateProvider>().contextData;
    if (!const DeepCollectionEquality().equals(prevContextData, contextData)) {
      // Stopwatch stopwatch = Stopwatch()..start();

      var newTWidgets = _getWidget(contextData[widget.pagePath] ?? {});

      setState(() {
        prevContextData.addAll(contextData);
        tWidgets = newTWidgets;
      });

      // print(
      //   'doSomething() executed in ${stopwatch.elapsed} ${widget.layout.type} ${widget.pagePath}',
      // );
    }
  }

  Map<String, dynamic> prevContextData = {};

  @override
  Widget build(BuildContext context) {
    _updateTWidgets(context);
    return tWidgets ?? const SizedBox.shrink();
  }
}
