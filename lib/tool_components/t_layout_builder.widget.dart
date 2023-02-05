import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_builder_item_props/layout_builder_item_props.dart';
import 'package:the_tool/t_widget_interface/layout_builder_props/layout_builder_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

class T_LayoutBuilder extends TWidget {
  T_LayoutBuilder({
    Key? key,
    required widgetUuid,
    required widgetProps,
    required pagePath,
    required T_LayoutBuilderProps layoutBuilder,
    childData = const {},
  }) : super(
          key: key,
          childData: childData,
          widgetUuid: widgetUuid,
          pagePath: pagePath,
          widgetProps: widgetProps,
          layoutBuilder: layoutBuilder,
        );

  @override
  State<T_LayoutBuilder> createState() => _T_LayoutBuilderState();
}

class _T_LayoutBuilderState extends TStatefulWidget<T_LayoutBuilder> {
  LayoutProps? _selectedLayout;
  String? layoutKey;

  Widget _prepareLayout(
    BoxConstraints boxConstraints,
  ) {
    var layouts = widget.layoutBuilder?.layouts;

    if (layouts == null || layouts.isEmpty) {
      throw Exception(
        "layout_builder widget must have children property specified",
      );
    }

    var layoutBuilderProps = layouts.firstWhere(
      (item) {
        LayoutProps? layoutProps = LayoutProps.fromJson(
          json.decode(jsonEncode(item)),
        );

        layoutProps = widget.utils.themeProvider
            .mergeClasses(layoutProps, widget.contextData);

        item = T_LayoutBuilderItemProps.fromJson(
          json.decode(jsonEncode(layoutProps)),
        );

        var maxHeight = widget.utils.computeSizeValue(
          item.maxHeight,
          widget.contextData,
        );

        var minHeight = widget.utils.computeSizeValue(
          item.minHeight,
          widget.contextData,
        );

        var maxWidth = widget.utils.computeSizeValue(
          item.maxWidth,
          widget.contextData,
        );

        var minWidth = widget.utils.computeSizeValue(
          item.minWidth,
          widget.contextData,
        );

        return boxConstraints.maxWidth > maxWidth;
      },
      orElse: () {
        var defaultLayoutIndex = widget.layoutBuilder?.defaultLayoutIndex ?? -1;

        return defaultLayoutIndex == -1
            ? const T_LayoutBuilderItemProps()
            : layouts[defaultLayoutIndex];
      },
    );

    print("boxConstraints ${boxConstraints}");

    if (layoutBuilderProps == null || layoutBuilderProps.child == null) {
      return const SizedBox.shrink();
    }

    if (!const DeepCollectionEquality()
        .equals(_selectedLayout, layoutBuilderProps.child!)) {
      layoutKey = const Uuid().v4();
    }
    print("boxConstraints.maxWidth ${boxConstraints.maxWidth}");
    _selectedLayout = layoutBuilderProps.child;

    return TWidgets(
      key: ValueKey(layoutKey),
      layout: layoutBuilderProps.child!,
      pagePath: widget.pagePath,
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _prepareLayout(constraints);
      },
    );
  }
}