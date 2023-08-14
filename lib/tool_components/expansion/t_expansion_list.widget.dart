import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/debouncer.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/twidget_props.dart';

class TExpansionList extends TWidget {
  TExpansionList(TWidgetProps twidget) : super(twidget);

  @override
  State<TExpansionList> createState() => _TExpansionListState();
}

class _TExpansionListState extends TStatefulWidget<TExpansionList> {
  late List<bool> _expansionIndex;
  late List<bool> _defaultExpansionIndex;
  var debouncer = Debouncer(delay: const Duration(milliseconds: 100));

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
    debouncer.run(() {
      _updateStateBaseOnContextData();
    });
    super.didChangeDependencies();
  }

  List<dynamic> _compareStateAndData() {
    final name = widget.widgetProps.name;

    if (name == null) return [true, null];

    final data = widget.getContexData()[name];
    if (data == null) return [true, null];

    if (UtilsManager.listEquals.equals(
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

    if (!isEqual && value != null) {
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
    var expansionItems = <ExpansionPanel>[];

    for (var i = 0; i < children.length; i++) {
      var child = children[i];
      _expansionIndex[i] = child.selected ?? _expansionIndex[i];

      expansionItems.add(
        ExpansionPanel(
          backgroundColor: ThemeDecoder.decodeColor(child.backgroundColor),
          isExpanded: _expansionIndex[i],
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            if (child.head == null) return const Offstage();
            return RepaintBoundary(
              child: TWidgets(
                layout: child.head!,
                pagePath: widget.pagePath,
                childData: childData ?? UtilsManager.emptyMapStringDynamic,
              ),
            );
          },
          body: TWidgets(
            layout: child.body!,
            pagePath: widget.pagePath,
            childData: childData ?? UtilsManager.emptyMapStringDynamic,
          ),
        ),
      );
    }
    return expansionItems;
  }

  Widget _computeExpanstionList(LayoutProps props) {
    var panelChildren = props.children ?? [];

    var childData = UtilsManager.emptyMapStringDynamic;
    if (props.name != null) {
      final contextData = widget.getContexData();
      childData["${props.name}"] = contextData[props.name];
      childData[UtilsManager.parentPrefix] = contextData;
    }

    return SingleChildScrollView(
      child: ExpansionPanelList(
        expandedHeaderPadding: const EdgeInsets.symmetric(
          vertical: 1.0,
        ),
        dividerColor: ThemeDecoder.decodeColor(props.dividerColor),
        elevation: props.elevation ?? 2.0,
        expansionCallback: _onExpansionCallback,
        children: _computeExpansionItems(panelChildren, childData),
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
