import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/fields/t_fields_widget.dart'
    deferred as t_fields;
import 'package:the_tool/tool_components/fields/t_form_widget.dart'
    deferred as t_form;
import 'package:the_tool/tool_components/t_avatar.widget.dart'
    deferred as t_avatar;
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_clickable.widget.dart';
import 'package:the_tool/tool_components/t_clipoval.widget.dart'
    deferred as t_clipoval;
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:the_tool/tool_components/t_component_widget.dart'
    deferred as t_component;
import 'package:the_tool/tool_components/t_expanded_widget.dart'
    deferred as t_expanded;
import 'package:the_tool/tool_components/t_grid_widget.dart' deferred as t_grid;
import 'package:the_tool/tool_components/t_icon_widget.dart' deferred as t_icon;
import 'package:the_tool/tool_components/t_layout_builder.widget.dart'
    deferred as t_layout_builder;
import 'package:the_tool/tool_components/t_row_widget.dart' deferred as t_row;
import 'package:the_tool/tool_components/t_scrollview_widget.dart'
    deferred as t_scrollview;
import 'package:the_tool/tool_components/datatable/t_datatable_widget.dart'
    deferred as t_table;
import 'package:the_tool/tool_components/t_stack_widget.dart';
import 'package:the_tool/tool_components/t_text_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:gato/gato.dart' as gato;

class TWidgets extends StatefulWidget {
  final LayoutProps layout;
  final String pagePath;
  Map<String, dynamic> childData;

  TWidgets({
    Key? key,
    required this.layout,
    required this.pagePath,
    this.childData = const {},
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

  Future<Widget> _getWidget(Map<String, dynamic> childData) async {
    LayoutProps content = widget.layout.content ?? widget.layout;
    // getIt<PageContextProvider>().registerTWidgetsProps(
    //   widgetUuid,
    //   widget.pagePath,
    //   content,
    //   contextData,
    // );

    if (tWidgets != null) {
      return tWidgets ?? const Offstage();
    }

    switch (content.type) {
      case "text":
        return T_Text(
          key: Key(widgetUuid),
          widgetProps: content,
          childData: childData,
          pagePath: widget.pagePath,
          widgetUuid: widgetUuid,
        );
      case "button":
        return T_Button(
          key: ValueKey(widgetUuid),
          widgetUuid: widgetUuid,
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
        );
      case "icon":
        await t_icon.loadLibrary();
        return t_icon.T_Icon(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          childData: childData,
          pagePath: widget.pagePath,
          widgetUuid: widgetUuid,
        );
      case "row":
        await t_row.loadLibrary();
        return t_row.T_Row(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "form":
        await t_form.loadLibrary();
        return t_form.T_Form(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "component":
        await t_component.loadLibrary();
        return t_component.T_Component(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          childData: childData,
          pagePath: widget.pagePath,
          widgetUuid: widgetUuid,
        );
      case "container":
        return T_Container(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "column":
        return T_Column(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "stack":
        return T_Stack(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          widgetUuid: widgetUuid,
          childData: childData,
        );
      case "grid":
        await t_grid.loadLibrary();
        return t_grid.T_Grid(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "scroll_view":
        await t_scrollview.loadLibrary();
        return t_scrollview.T_ScrollView(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );

      case "expanded":
        await t_expanded.loadLibrary();
        return t_expanded.T_Expanded(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "field":
        await t_fields.loadLibrary();
        return t_fields.T_Fields(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "table":
        await t_table.loadLibrary();
        return t_table.T_DataTable(
          key: ValueKey(widgetUuid),
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
          widgetUuid: widgetUuid,
        );
      case "layout_builder":
        assert(
          content.layoutBuilder != null,
          "layout_builder must have properties",
        );
        await t_layout_builder.loadLibrary();
        return t_layout_builder.T_LayoutBuilder(
          widgetUuid: widgetUuid,
          pagePath: widget.pagePath,
          childData: childData,
          widgetProps: content,
          layoutBuilder: content.layoutBuilder!,
        );
      case "clickable":
        return T_Clickable(
          widgetUuid: widgetUuid,
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
        );
      case "circle_avatar":
        await t_avatar.loadLibrary();
        return t_avatar.T_Avatar(
          widgetUuid: widgetUuid,
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
        );
      case "clip_oval":
        await t_clipoval.loadLibrary();
        return t_clipoval.T_ClipOval(
          widgetUuid: widgetUuid,
          widgetProps: content,
          pagePath: widget.pagePath,
          childData: childData,
        );
      default:
        return _computeNotBuiltInWidget(childData, content);
    }
  }

  Widget _computeNotBuiltInWidget(
    Map<String, dynamic> childData,
    LayoutProps content,
  ) {
    var contextStateProvider = getIt<ContextStateProvider>();
    LayoutProps? innerComponent = gato.get(
      contextStateProvider.pageComponents,
      "${widget.pagePath}.${content.component}",
    );
    if (innerComponent != null) {
      return TWidgets(
        childData: childData,
        layout: innerComponent.merge(content),
        pagePath: widget.pagePath,
      );
    }
    if (content.type == null && content.component == null) {
      return const Offstage();
    }
    return Text(
        "Unsupported widget. Type: ${content.type ?? content.component}");
  }

  Future<void> _updateTWidgets(
    BuildContext context,
  ) async {
    if (tWidgets == null) {
      // Stopwatch stopwatch = Stopwatch()..start();
      // var contextData = context.read<ContextStateProvider>().contextData;
      var newTWidgets = await _getWidget(widget.childData);

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
    return tWidgets ?? const Offstage();
  }
}
