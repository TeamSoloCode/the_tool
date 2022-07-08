import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';

part 'layout_props.freezed.dart';
part 'layout_props.g.dart';

@freezed
class LayoutProps with _$LayoutProps {
  const factory LayoutProps({
    String? color,
    String? backgroundColor,
    String? text,
    dynamic hidden,
    String? icon,
    String? mainAxisAlignment,
    String? path,
    String? onClick,
    String? buttonType,
    String? key,
    String? name,
    dynamic items,
    String? fieldType,
    LayoutProps? child,
    LayoutProps? content,
    List<LayoutProps>? children,
    BottomNavigationProps? bottomNav,
  }) = _LayoutProps;

  factory LayoutProps.fromJson(Map<String, Object?> json) =>
      _$LayoutPropsFromJson(json);
}
