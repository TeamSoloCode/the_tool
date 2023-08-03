import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

part 'bottom_nav_item_props.freezed.dart';
part 'bottom_nav_item_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class BottomNavigationItemProps with _$BottomNavigationItemProps {
  const factory BottomNavigationItemProps({
    String? label,
    LayoutProps? icon,
    LayoutProps? activeIcon,
    String? path,
    String? backgroundColor,
  }) = _BottomNavigationItemProps;

  factory BottomNavigationItemProps.fromJson(Map<String, Object?> json) =>
      _$BottomNavigationItemPropsFromJson(json);
}
