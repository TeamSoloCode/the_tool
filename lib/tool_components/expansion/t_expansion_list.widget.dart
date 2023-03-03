import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_ExpansionList extends TWidget {
  T_ExpansionList({
    Key? key,
    required widgetProps,
    required widgetUuid,
    required pagePath,
    childData = const {},
  }) : super(
          key: key,
          widgetUuid: widgetUuid,
          pagePath: pagePath,
          widgetProps: widgetProps,
          childData: childData,
        );

  @override
  State<T_ExpansionList> createState() => _T_ExpansionListState();
}

class _T_ExpansionListState extends TStatefulWidget<T_ExpansionList> {
  late List<bool> _expansionIndex;

  @override
  void initState() {
    _expansionIndex = List.filled(
      widget.widgetProps.children?.length ?? 0,
      false,
    );

    super.initState();
  }

  List<ExpansionPanel> _computeExpansionItems(
    List<LayoutProps> children,
    Map<String, dynamic>? childData,
  ) {
    var index = 0;

    return children.map(
      (child) {
        _expansionIndex[index] = child.selected != null
            ? UtilsManager.isTruthy(child.selected)
            : _expansionIndex[index];

        var result = ExpansionPanel(
          backgroundColor: ThemeDecoder.decodeColor(
            child.head?.backgroundColor,
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

        index++;

        return result;
      },
    ).toList();
  }

  Widget _computeExpanstionList(LayoutProps props) {
    var panelChildren = props.children ?? [];

    var childData = UtilsManager.emptyMapStringDynamic;
    if (props.name != null) {
      childData = widget.getContexData()[props.name] ??
          UtilsManager.emptyMapStringDynamic;
    }
    var elevation = props.elevation;

    return SingleChildScrollView(
      child: ExpansionPanelList(
        dividerColor: ThemeDecoder.decodeColor(props.dividerColor),
        elevation: elevation != null ? elevation : 2.0,
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _expansionIndex[panelIndex] = !isExpanded;
          });
        },
        children: _computeExpansionItems(panelChildren, childData),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;

    if (widget.props != null) {
      _snapshot = _computeExpanstionList(widget.props!);
    }

    return _snapshot;
  }
}
