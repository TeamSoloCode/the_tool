import 'dart:convert';

import 'package:flutter/foundation.dart';
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

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // FIXME: This because on web platform it not triggered didChangeDependencies when contextData change
    if (!kIsWeb) {
      _updateStateBaseOnContextData();
    }
    super.didChangeDependencies();
  }

  void _updateStateBaseOnContextData() {
    var name = widget.widgetProps.name;

    if (name != null) {
      var data = widget.getContexData()[name];
      if (data != null &&
          !const DeepCollectionEquality().equals(
            data,
            _expansionIndex,
          )) {
        setState(() {
          _expansionIndex =
              data is! List ? _defaultExpansionIndex : List<bool>.from(data);
        });
      }
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

        _expansionIndex[index] = child.selected != null
            ? UtilsManager.isTruthy(child.selected)
            : _expansionIndex[index];

        return ExpansionPanel(
          backgroundColor: ThemeDecoder.decodeColor(
            child.backgroundColor,
          ),
          isExpanded: _expansionIndex[index],
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            if (child.head == null) return const Offstage();
            return TWidgets(
              layout: child.head!,
              pagePath: widget.pagePath,
              childData: childData ?? const {},
            );
          },
          body: child.body == null
              ? const Offstage()
              : TWidgets(
                  layout: child.body!,
                  pagePath: widget.pagePath,
                  childData: childData ?? const {},
                ),
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
      child: ExpansionPanelList(
        expandedHeaderPadding: const EdgeInsets.symmetric(
          vertical: 1.0,
        ),
        dividerColor: ThemeDecoder.decodeColor(props.dividerColor),
        elevation: elevation ?? 2.0,
        expansionCallback: _onExpansionCallback,
        children: _computeExpansionItems(panelChildren, childData),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    // FIXME: This because on web platform it not triggered didChangeDependencies when contextData change
    if (kIsWeb) {
      _updateStateBaseOnContextData();
    }
    if (widget.props != null) {
      _snapshot = _computeExpanstionList(widget.props!);
    }

    return _snapshot;
  }
}
