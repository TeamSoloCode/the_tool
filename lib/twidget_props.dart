library common_interface;

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/drawer_props/drawer_props.dart';
import 'package:the_tool/t_widget_interface/layout_builder_props/layout_builder_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

class TWidgetProps {
  Key? key;
  late LayoutProps widgetProps;
  late String pagePath;
  String widgetUuid;
  Map<String, dynamic> childData = const {};
  T_LayoutBuilderProps? layoutBuilder;
  T_DrawerProps? drawerProps;
  LayoutProps? childProps;

  TWidgetProps({
    this.key,
    required this.widgetProps,
    required this.pagePath,
    required this.widgetUuid,
    this.childData = const {},
    this.layoutBuilder,
    this.drawerProps,
    this.childProps,
  });
}
