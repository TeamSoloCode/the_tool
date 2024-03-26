import 'package:flutter/material.dart';
import 'package:the_tool/tool_components/expansion/t_expansion_tile.widget.dart'
    deferred as t_expansion_tile;
import 'package:the_tool/tool_components/popup/t_snackbar.widget.dart'
    deferred as t_snackbar;
import 'package:the_tool/tool_components/t_dismissable.widget.dart'
    deferred as t_dismissable;
import 'package:the_tool/tool_components/t_flexible.widget.dart';
import 'package:the_tool/tool_components/t_safe_area.widget.dart';
import 'package:the_tool/tool_components/t_wrap.widget.dart';
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.extension.dart';
import 'package:the_tool/tool_components/t_visibility.widget.dart'
    deferred as t_visibility;
import 'package:the_tool/tool_components/t_divider.widget.dart'
    deferred as t_divider;
import 'package:the_tool/tool_components/list/t_list_tile.widget.dart'
    deferred as t_list_tile;
import 'package:the_tool/tool_components/expansion/t_expansion_list.widget.dart'
    deferred as t_expansion_list;
import 'package:the_tool/tool_components/fields/t_fields_widget.dart'
    deferred as t_fields;
import 'package:the_tool/tool_components/t_sized_box.dart';
import 'package:the_tool/tool_components/fields/t_form_widget.dart'
    deferred as t_form;
import 'package:the_tool/tool_components/t_avatar.widget.dart'
    deferred as t_avatar;
import 'package:the_tool/tool_components/t_button_widget.dart';
import 'package:the_tool/tool_components/t_clickable.widget.dart'
    deferred as t_clickable;
import 'package:the_tool/tool_components/t_clipoval.widget.dart'
    deferred as t_clipoval;
import 'package:the_tool/tool_components/t_column_widget.dart';
import 'package:the_tool/tool_components/t_container_widget.dart';
import 'package:the_tool/tool_components/t_component_widget.dart'
    deferred as t_component;
import 'package:the_tool/tool_components/t_expanded_widget.dart';
import 'package:the_tool/tool_components/t_grid_widget.dart' deferred as t_grid;
import 'package:the_tool/tool_components/t_icon_widget.dart';
import 'package:the_tool/tool_components/t_layout_builder.widget.dart'
    deferred as t_layout_builder;
import 'package:the_tool/tool_components/t_row_widget.dart';
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
import 'package:the_tool/tool_components/t_opacity.widget.dart'
    deferred as t_opacity;
import 'package:the_tool/tool_components/popup/t_bottom_sheet.widget.dart'
    deferred as t_bottom_sheet;
import 'package:the_tool/tool_components/popup/t_dialog.widget.dart'
    deferred as t_dialog;
import 'package:the_tool/tool_components/t_gesture_detector.widget.dart'
    deferred as t_gesture_detector;

import 'package:the_tool/tool_components/t_stack_widget.dart';
import 'package:the_tool/tool_components/t_text_widget.dart';
import 'package:the_tool/utils.dart';

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
  String widgetUuid = UniqueKey().toString();
  var utils = getIt<UtilsManager>();

  Future<Widget> _computeTWidgets(
    LayoutProps content,
    TWidgetProps tWidgetProps,
    Map<String, dynamic> childData,
  ) async {
    switch (content.type) {
      case "text":
        return TText(tWidgetProps);
      case "button":
        return TButton(tWidgetProps);
      case "icon":
        return T_Icon(tWidgetProps);
      case "row":
        return T_Row(tWidgetProps);
      case "container":
        return TContainer(tWidgetProps);
      case "column":
        return T_Column(tWidgetProps);
      case "stack":
        return T_Stack(tWidgetProps);
      case "expanded":
        return T_Expanded(tWidgetProps);
      case "flexible":
        return TFlexible(tWidgetProps);
      case "sized_box":
        return TSizedBox(tWidgetProps);
      case "wrap":
        return TWrap(tWidgetProps);
      case "safe_area":
        return TSafeArea(tWidgetProps);
      case "align":
        return TAlign(tWidgetProps);

      case "form":
        await t_form.loadLibrary();
        return t_form.T_Form(tWidgetProps);
      case "component":
        await t_component.loadLibrary();
        return t_component.TComponent(tWidgetProps);
      case "grid":
        await t_grid.loadLibrary();
        return t_grid.TGrid(tWidgetProps);
      case "scroll_view":
        await t_scrollview.loadLibrary();
        return t_scrollview.T_ScrollView(tWidgetProps);
      case "field":
        await t_fields.loadLibrary();
        return t_fields.TFields(tWidgetProps);
      case "table":
        await t_table.loadLibrary();
        return t_table.TDataTable(tWidgetProps);
      case "layout_builder":
        if (tWidgetProps.layoutBuilder == null) {
          throw Exception("layout_builder must have properties");
        }
        await t_layout_builder.loadLibrary();
        return t_layout_builder.T_LayoutBuilder(tWidgetProps);
      case "clickable":
        await t_clickable.loadLibrary();
        return t_clickable.T_Clickable(tWidgetProps);
      case "circle_avatar":
        await t_avatar.loadLibrary();
        return t_avatar.T_Avatar(tWidgetProps);
      case "clip_oval":
        await t_clipoval.loadLibrary();
        return t_clipoval.T_ClipOval(tWidgetProps);
      case "list":
        await t_listview.loadLibrary();
        return t_listview.TListView(tWidgetProps);
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
      case "expansion_tile":
        await t_expansion_tile.loadLibrary();
        return t_expansion_tile.TExpansionTitle(tWidgetProps);
      case "opacity":
        await t_opacity.loadLibrary();
        return t_opacity.TOpacity(tWidgetProps);
      case "bottom_sheet":
        await t_bottom_sheet.loadLibrary();
        return t_bottom_sheet.TBottomSheet(tWidgetProps);
      case "dialog":
        await t_dialog.loadLibrary();
        return t_dialog.TAlertDialog(tWidgetProps);
      case "snackbar":
        await t_snackbar.loadLibrary();
        return t_snackbar.TSnackBar(tWidgetProps);
      case "gesture_detector":
        await t_gesture_detector.loadLibrary();
        return t_gesture_detector.TGestureDetector(tWidgetProps);
      case "dismissable":
        await t_dismissable.loadLibrary();
        return t_dismissable.TDismissable(tWidgetProps);
      case "visibility":
        await t_visibility.loadLibrary();
        return t_visibility.TVisibility(tWidgetProps);
      case "divider":
        await t_divider.loadLibrary();
        return t_divider.TDivider(tWidgetProps);
      default:
        throw Exception("Not found: \"${content.type}\" widget");
    }
  }

  Future<Widget> _getWidget(Map<String, dynamic> childData) async {
    LayoutProps content = widget.layout.content ?? widget.layout;
    if (widget.layout.type != null) {
      content = widget.layout;
    }

    TWidgetProps tWidgetProps;
    if (content.type != null) {
      tWidgetProps = TWidgetProps(
        key: Key(widgetUuid),
        widgetProps: content,
        pagePath: widget.pagePath,
        widgetUuid: widgetUuid,
        childData: childData,
        layoutBuilder: content.layoutBuilder,
      );

      tWidgets = await _computeTWidgets(content, tWidgetProps, childData);
    } else {
      tWidgets = _computeNotBuiltInWidget(childData, content);
    }

    /// Should use wrapper for utilities widgets. Ex: Padding, Align, Opacity, ...
    /// This will make the performance better
    return UtilsManager.applyWrappers(content, tWidgets!);
  }

  Widget _computeNotBuiltInWidget(
    Map<String, dynamic> childData,
    LayoutProps content,
  ) {
    final contextStateProvider = getIt<ContextStateProvider>();
    LayoutProps? innerComponent = UtilsManager.get(
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
