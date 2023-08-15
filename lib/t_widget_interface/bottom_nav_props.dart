import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';
import 'package:the_tool/utils.dart';

class DecodeBottomNavigation {
  final String pagePath;
  final BottomNavigationProps bottomNavConfig;
  Map<String, dynamic> contextData;
  BottomNavigationBarType? _type;
  Color? _selectedItemColor;
  late List<BottomNavigationBarItem> _items;

  DecodeBottomNavigation({
    required this.bottomNavConfig,
    required this.pagePath,
    required this.contextData,
  }) : super() {
    _type = ThemeDecoder.decodeBottomNavigationBarType(
      bottomNavConfig.navType,
    );

    _selectedItemColor = ThemeDecoder.decodeColor(
      bottomNavConfig.selectedItemColor,
    );

    var items = bottomNavConfig.items;
    List<BottomNavigationBarItem> bottomNavItems = (items ?? []).map((item) {
      if (item.icon == null) {
        throw Exception("Please provide icon in bottom navigation item");
      }

      return BottomNavigationBarItem(
        label: item.label,
        // icon: Text("Home Inactive"),
        // activeIcon: Text("Home Active"),

        icon: UtilsManager.computeTWidgets(
          item.icon,
          pagePath: pagePath,
          childData: UtilsManager.emptyMapStringDynamic,
        )!,
        activeIcon: UtilsManager.computeTWidgets(
          item.activeIcon,
          pagePath: pagePath,
          childData: UtilsManager.emptyMapStringDynamic,
        ),
        backgroundColor: ThemeDecoder.decodeColor(
          item.backgroundColor,
        ),
      );
    }).toList();

    _items = bottomNavItems;
  }

  BottomNavigationBarType? get type => _type;
  Color? get selectedItemColor => _selectedItemColor;
  List<BottomNavigationBarItem> get items => _items;
}
