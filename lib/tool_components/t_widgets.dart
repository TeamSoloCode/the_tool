import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_fields_widget.dart'
    deferred as T_Fields;
import 'package:the_tool/tool_components/fields/t_form_widget.dart'
    deferred as T_Form;
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:the_tool/tool_components/t_component_widget.dart'
    deferred as T_Component;
import 'package:the_tool/tool_components/t_expanded_widget.dart';
import 'package:the_tool/tool_components/t_grid_widget.dart' deferred as T_Grid;
import 'package:the_tool/tool_components/t_icon_widget.dart';
import 'package:the_tool/tool_components/t_row_widget.dart';
import 'package:the_tool/tool_components/t_scrollview_widget.dart'
    deferred as T_ScrollView;
import 'package:the_tool/tool_components/t_datatable_widget.dart'
    deferred as T_Table;
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
  String widgetUuid = const Uuid().v4();

  @override
  void dispose() {
    // getIt<PageContextProvider>().unregisterTWidgetsProps(widgetUuid);
    super.dispose();
  }

  Future<Widget> _getWidget(Map<String, dynamic> contextData) async {
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
        await T_Form.loadLibrary();
        return T_Form.T_Form(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "component":
        await T_Component.loadLibrary();
        return T_Component.T_Component(
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
        await T_Grid.loadLibrary();
        return T_Grid.T_Grid(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "scroll_view":
        await T_ScrollView.loadLibrary();
        return T_ScrollView.T_ScrollView(
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
        await T_Fields.loadLibrary();
        return T_Fields.T_Fields(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      case "table":
        await T_Table.loadLibrary();
        return T_Table.T_DataTable(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          contextData: contextData,
          widgetUuid: widgetUuid,
        );
      default:
        return _computeNotBuiltInWidget(contextData, content);
    }
  }

  Widget _computeNotBuiltInWidget(
    Map<String, dynamic> contextData,
    LayoutProps content,
  ) {
    var contextStateProvider = getIt<ContextStateProvider>();
    LayoutProps? innerComponent = gato.get(
      contextStateProvider.pageComponents,
      "${widget.pagePath}.${content.component}",
    );
    if (innerComponent != null) {
      return TWidgets(
        contextData: contextData,
        layout: innerComponent.merge(content),
        pagePath: widget.pagePath,
      );
    }
    if (content.type == null && content.component == null) {
      return const SizedBox();
    }
    return Text(
        "Unsupported widget. Type: ${content.type ?? content.component}");
  }

  Future<void> _updateTWidgets(
    BuildContext context,
  ) async {
    if (tWidgets == null) {
      // Stopwatch stopwatch = Stopwatch()..start();
      var contextData = context.read<ContextStateProvider>().contextData;
      var newTWidgets = await _getWidget(contextData[widget.pagePath] ?? {});

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
