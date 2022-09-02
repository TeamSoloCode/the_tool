import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

part 'app_bar_props.freezed.dart';
part 'app_bar_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class AppBarProps with _$AppBarProps {
  const factory AppBarProps({
    LayoutProps? content,
    LayoutProps? custom,
  }) = _AppBarProps;

  factory AppBarProps.fromJson(Map<String, Object?> json) =>
      _$AppBarPropsFromJson(json);
}
