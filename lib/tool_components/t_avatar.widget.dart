import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_builder_item_props/layout_builder_item_props.dart';
import 'package:the_tool/t_widget_interface/layout_builder_props/layout_builder_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

class T_Avatar extends TWidget {
  T_Avatar({
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
        );

  @override
  State<T_Avatar> createState() => _T_AvatarState();
}

class _T_AvatarState extends TStatefulWidget<T_Avatar> {
  @override
  Widget buildWidget(BuildContext context) {
    return SizedBox();
  }
}
