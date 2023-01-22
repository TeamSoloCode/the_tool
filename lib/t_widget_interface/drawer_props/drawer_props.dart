import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

part 'drawer_props.freezed.dart';
part 'drawer_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class T_DrawerProps with _$T_DrawerProps {
  const factory T_DrawerProps({
    LayoutProps? child,
    String? backgroundColor,
    dynamic width,
    double? elevation,
  }) = _T_DrawerProps;

  factory T_DrawerProps.fromJson(Map<String, Object?> json) =>
      _$T_DrawerPropsFromJson(json);
}
