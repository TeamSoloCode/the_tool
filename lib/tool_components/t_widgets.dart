import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/expansion/t_expansion_tile.widget.dart'
    deferred as t_expansion_tile;
import 'package:the_tool/tool_components/t_flexible.widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/list/t_list_tile.widget.dart'
    deferred as t_list_tile;
import 'package:the_tool/tool_components/expansion/t_expansion_list.widget.dart'
    deferred as t_expansion_list;
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
import 'package:the_tool/tool_components/list/t_listview.widget.dart'
    deferred as t_listview;
import 'package:the_tool/tool_components/t_card.widget.dart' deferred as t_card;
import 'package:the_tool/tool_components/t_center.widget.dart'
    deferred as t_center;
import 'package:the_tool/tool_components/t_padding.widget.dart'
    deferred as t_padding;
import 'package:the_tool/tool_components/t_align.widget.dart';

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
    required this.childData,
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
      return tWidgets!;
    }

    late TWidgetProps tWidgetProps;
    if (content.type != null) {
      tWidgetProps = TWidgetProps(
        key: Key(widgetUuid),
        widgetProps: content,
        pagePath: widget.pagePath,
        widgetUuid: widgetUuid,
        childData: childData,
        layoutBuilder: content.layoutBuilder,
      );
    }

    switch (content.type) {
      case "text":
        return TText(tWidgetProps);
      case "button":
        return T_Button(tWidgetProps);
      case "icon":
        await t_icon.loadLibrary();
        return t_icon.T_Icon(tWidgetProps);
      case "row":
        await t_row.loadLibrary();
        return t_row.T_Row(tWidgetProps);
      case "form":
        await t_form.loadLibrary();
        return t_form.T_Form(tWidgetProps);
      case "component":
        await t_component.loadLibrary();
        return t_component.TComponent(tWidgetProps);
      case "container":
        return TContainer(tWidgetProps);
      case "column":
        return T_Column(tWidgetProps);
      case "stack":
        return T_Stack(tWidgetProps);
      case "grid":
        await t_grid.loadLibrary();
        return t_grid.T_Grid(tWidgetProps);
      case "scroll_view":
        await t_scrollview.loadLibrary();
        return t_scrollview.T_ScrollView(tWidgetProps);
      case "expanded":
        await t_expanded.loadLibrary();
        return t_expanded.T_Expanded(tWidgetProps);
      case "flexible":
        return TFlexible(tWidgetProps);
      case "field":
        await t_fields.loadLibrary();
        return t_fields.T_Fields(tWidgetProps);
      case "table":
        await t_table.loadLibrary();
        return t_table.T_DataTable(tWidgetProps);
      case "layout_builder":
        assert(
          tWidgetProps.layoutBuilder != null,
          "layout_builder must have properties",
        );
        await t_layout_builder.loadLibrary();
        return t_layout_builder.T_LayoutBuilder(tWidgetProps);
      case "clickable":
        return T_Clickable(tWidgetProps);
      case "circle_avatar":
        await t_avatar.loadLibrary();
        return t_avatar.T_Avatar(tWidgetProps);
      case "clip_oval":
        await t_clipoval.loadLibrary();
        return t_clipoval.T_ClipOval(tWidgetProps);
      case "list":
        await t_listview.loadLibrary();
        return t_listview.T_ListView(tWidgetProps);
      case "expansion_list":
        await t_expansion_list.loadLibrary();
        return t_expansion_list.TExpansionList(tWidgetProps);
      case "list_tile":
        await t_list_tile.loadLibrary();
        return t_list_tile.TListTile(tWidgetProps);
      case "card":
        await t_card.loadLibrary();
        return t_card.TCard(tWidgetProps);
      case "center":
        await t_center.loadLibrary();
        return t_center.TCenter(tWidgetProps);
      case "padding":
        await t_padding.loadLibrary();
        return t_padding.TPadding(tWidgetProps);
      case "align":
        return TAlign(tWidgetProps);
      case "expansion_tile":
        await t_expansion_tile.loadLibrary();
        return t_expansion_tile.TExpansionTitle(tWidgetProps);
      default:
        return _computeNotBuiltInWidget(childData, content);
    }
  }

  Widget _computeNotBuiltInWidget(
    Map<String, dynamic> childData,
    LayoutProps content,
  ) {
    final contextStateProvider = getIt<ContextStateProvider>();
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
