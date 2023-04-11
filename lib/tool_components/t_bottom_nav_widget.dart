library t_bottom_nav;

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/bottom_nav_props.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';
import 'package:the_tool/tool_components/page_widget.dart';

List<Widget> computeBottomNavigationPages(
  BuildContext context,
  BottomNavigationProps? bottomNavConfig, {
  required String Function(String) updatePageIdMap,
}) {
  var size = MediaQuery.of(context).size;
  if (bottomNavConfig == null || bottomNavConfig.items == null) {
    return [];
  }

  var items = bottomNavConfig.items;
  List<Widget> pages = (items ?? []).map((item) {
    if (item.path == null) {
      throw Exception("Please provide path in bottom navigation iten");
    }

    // this make SubPage not changed key and re-render
    ValueKey pageKey = ValueKey(updatePageIdMap(item.path!));
    return SizedBox(
      height: size.height,
      width: size.width,
      child: TPage(
        key: pageKey,
        pagePath: item.path!,
      ),
    );
  }).toList();

  return pages;
}

Widget? computeBottomNavigationBar(
    Map<String, dynamic> contextData, BottomNavigationProps? bottomNavConfig,
    {int currentIndex = 0, void Function(int)? onTap}) {
  if (bottomNavConfig == null || bottomNavConfig.items == null) {
    return null;
  }

  var bottomNavProps = DecodeBottomNavigation(
    bottomNavConfig: bottomNavConfig,
  );

  return BottomNavigationBar(
    type: bottomNavProps.type,
    items: bottomNavProps.items,
    selectedItemColor: bottomNavProps.selectedItemColor,
    currentIndex: currentIndex,
    onTap: onTap,
  );
}
