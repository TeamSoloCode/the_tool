import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';

class DecodeBottomNavigation {
  final BottomNavigationProps bottomNavConfig;
  BottomNavigationBarType? _type;
  Color? _selectedItemColor;
  late List<BottomNavigationBarItem> _items;

  DecodeBottomNavigation({required this.bottomNavConfig}) : super() {
    _type = ThemeDecoder.decodeBottomNavigationBarType(
      bottomNavConfig.navType,
    );

    String? cssColor = bottomNavConfig.selectedItemColor;
    Color? color = cssColor != null ? fromCssColor(cssColor) : null;
    _selectedItemColor = color;

    var items = bottomNavConfig.items;
    List<BottomNavigationBarItem> bottomNavItems = (items ?? []).map((item) {
      String? cssColor = item.backgroundColor;
      Color? color = cssColor != null ? fromCssColor(cssColor) : null;

      return BottomNavigationBarItem(
        label: item.label,
        icon: Icon(MdiIcons.fromString(item.icon ?? "")),
        backgroundColor: color,
      );
    }).toList();

    _items = bottomNavItems;
  }

  BottomNavigationBarType? get type => _type;
  Color? get selectedItemColor => _selectedItemColor;
  List<BottomNavigationBarItem> get items => _items;
}
