import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:the_tool/twidget_props.dart';

class TExpansionList extends TWidget {
  TExpansionList(TWidgetProps twidget) : super(twidget);

  @override
  State<TExpansionList> createState() => _TExpansionListState();
}

class _TExpansionListState extends TStatefulWidget<TExpansionList> {
  late List<bool> _expansionIndex;
  late List<bool> _defaultExpansionIndex;

  @override
  void initState() {
    _defaultExpansionIndex = List.filled(
      widget.widgetProps.children?.length ?? 0,
      false,
    );
    _expansionIndex = _defaultExpansionIndex;

    final result = _compareStateAndData();
    final isEqual = result.elementAt(0);
    final value = result.elementAt(1);
    if (isEqual == false) {
      _expansionIndex = value;
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _updateStateBaseOnContextData();
    super.didChangeDependencies();
  }

  List<dynamic> _compareStateAndData() {
    final name = widget.widgetProps.name;

    if (name == null) return [true, null];

    final data = widget.getContexData()[name];
    if (data == null) return [true, null];

    if (const DeepCollectionEquality().equals(
      data,
      _expansionIndex,
    )) return [true, null];

    return [
      false,
      data is! List ? _defaultExpansionIndex : List<bool>.from(data),
    ];
  }

  void _updateStateBaseOnContextData() {
    final result = _compareStateAndData();
    final isEqual = result.elementAt(0);
    final value = result.elementAt(1);

    if (isEqual != true) {
      setState(() {
        _expansionIndex = List<bool>.from(value);
      });
    }
  }

  void _onExpansionCallback(int panelIndex, bool isExpanded) {
    setState(() {
      _expansionIndex[panelIndex] = !isExpanded;
      var name = widget.widgetProps.name;

      if (name != null) {
        widget.setPageData({name: _expansionIndex});
      }
    });
  }

  List<ExpansionPanel> _computeExpansionItems(
    List<LayoutProps> children,
    Map<String, dynamic>? childData,
  ) {
    var index = -1;

    return children.map(
      (child) {
        index++;

        _expansionIndex[index] =
            child.selected != null ? !!child.selected : _expansionIndex[index];
        var abcd = TWidgets(
          layout: child.head!,
          pagePath: widget.pagePath,
          childData: childData ?? const {},
        );
        var abcd1 = child.body == null
            ? const Offstage()
            : TWidgets(
                layout: child.body!,
                pagePath: widget.pagePath,
                childData: childData ?? const {},
              );
        return ExpansionPanel(
          backgroundColor: ThemeDecoder.decodeColor(
            child.backgroundColor,
          ),
          isExpanded: _expansionIndex[index],
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            if (child.head == null) return const Offstage();

            return abcd;
          },
          body: abcd1,
        );
      },
    ).toList();
  }

  Widget _computeExpanstionList(LayoutProps props) {
    var panelChildren = props.children ?? [];

    var childData = UtilsManager.emptyMapStringDynamic;
    if (props.name != null) {
      final contextData = widget.getContexData();
      childData["${props.name}"] = contextData[props.name];
      childData[UtilsManager.parentPrefix] = contextData;
    }
    var elevation = props.elevation;

    return SingleChildScrollView(
      child: RepaintBoundary(
        child: ExpansionPanelList(
          expandedHeaderPadding: const EdgeInsets.symmetric(
            vertical: 1.0,
          ),
          dividerColor: ThemeDecoder.decodeColor(props.dividerColor),
          elevation: elevation ?? 2.0,
          expansionCallback: _onExpansionCallback,
          children: _computeExpansionItems(panelChildren, childData),
        ),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (widget.props != null) {
      snapshot = _computeExpanstionList(widget.props!);
    }

    return snapshot;
  }
}
