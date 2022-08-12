import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
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
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:gato/gato.dart' as gato;

class TWidgets extends StatefulWidget {
  final LayoutProps layout;
  final String pagePath;
  Map<String, dynamic> contextData;

  TWidgets({
    Key? key,
    required this.layout,
    required this.pagePath,
    required this.contextData,
  }) : super(key: key);

  @override
  State<TWidgets> createState() => _TWidgetsState();
}

class _TWidgetsState extends State<TWidgets> {
  Widget? tWidgets;
  final widgetUuid = const Uuid().v4();

  @override
  void dispose() {
    // getIt<PageContextProvider>().unregisterTWidgetsProps(widgetUuid);
    super.dispose();
  }

  Widget _getWidget(Map<String, dynamic> contextData) {
    LayoutProps content = widget.layout.content ?? widget.layout;
    // getIt<PageContextProvider>().registerTWidgetsProps(
    //   widgetUuid,
    //   widget.pagePath,
    //   content,
    //   contextData,
    // );

    if (tWidgets != null) {
      return tWidgets ?? const SizedBox.shrink();
    }

    switch (content.type) {
      case "text":
        return T_Text(
          key: Key(widgetUuid),
          widgetProps: content,
          contextData: contextData,
          pagePath: widget.pagePath,
          widgetUuid: widgetUuid,
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
          widgetUuid: widgetUuid,
        );
      case "row":
        return T_Row(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "form":
        return T_Form(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "component":
        return T_Component(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          contextData: contextData,
          pagePath: widget.pagePath,
          widgetUuid: widgetUuid,
        );
      case "container":
        return T_Container(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "column":
        return T_Column(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "grid":
        return T_Grid(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "scroll_view":
        return T_ScrollView(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );

      case "expanded":
        return T_Expanded(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          parentData: contextData,
          widgetUuid: widgetUuid,
        );
      case "field":
        return T_Fields(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      default:
        var contextStateProvider = getIt<ContextStateProvider>();
        LayoutProps? innerComponent = gato.get(
          contextStateProvider.pageComponents,
          "${widget.pagePath}.${content.type}",
        );
        if (innerComponent != null) {
          return TWidgets(
            contextData: contextData,
            layout: innerComponent,
            pagePath: widget.pagePath,
          );
        }
        return const SizedBox.shrink();
    }
  }

  Future<void> _updateTWidgets(
    BuildContext context,
  ) async {
    if (tWidgets == null) {
      // Stopwatch stopwatch = Stopwatch()..start();
      var contextData = context.read<ContextStateProvider>().contextData;
      var newTWidgets = _getWidget(contextData[widget.pagePath] ?? {});

      setState(() {
        tWidgets = newTWidgets;
      });

      // print(
      //   'doSomething() executed in ${stopwatch.elapsed} ${widget.layout.type} ${widget.pagePath}',
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateTWidgets(context);
    return tWidgets ?? const SizedBox.shrink();
  }
}
