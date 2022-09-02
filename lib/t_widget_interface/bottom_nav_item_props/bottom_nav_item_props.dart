import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'bottom_nav_item_props.freezed.dart';
part 'bottom_nav_item_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class BottomNavigationItemProps with _$BottomNavigationItemProps {
  const factory BottomNavigationItemProps({
    String? label,
    String? icon,
    String? path,
    String? backgroundColor,
  }) = _BottomNavigationItemProps;

  factory BottomNavigationItemProps.fromJson(Map<String, Object?> json) =>
      _$BottomNavigationItemPropsFromJson(json);
}
