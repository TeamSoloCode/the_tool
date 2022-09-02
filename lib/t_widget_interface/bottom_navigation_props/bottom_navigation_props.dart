import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/bottom_nav_item_props/bottom_nav_item_props.dart';

part 'bottom_navigation_props.freezed.dart';
part 'bottom_navigation_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class BottomNavigationProps with _$BottomNavigationProps {
  const factory BottomNavigationProps({
    String? selectedItemColor,
    String? navType,
    List<BottomNavigationItemProps>? items,
  }) = _BottomNavigationProps;

  factory BottomNavigationProps.fromJson(Map<String, Object?> json) =>
      _$BottomNavigationPropsFromJson(json);
}
