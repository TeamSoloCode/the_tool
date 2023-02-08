import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

part 'media_screen_only.freezed.dart';
part 'media_screen_only.g.dart';

@Freezed(equal: false, toStringOverride: false)
class T_MediaScreenOnlyProps with _$T_MediaScreenOnlyProps {
  const factory T_MediaScreenOnlyProps({
    num? maxWidth,
    num? minWidth,
    num? maxHeight,
    num? minHeight,
    String? orientation,
    LayoutProps? style,
  }) = _T_MediaScreenOnlyProps;

  factory T_MediaScreenOnlyProps.fromJson(Map<String, Object?> json) =>
      _$T_MediaScreenOnlyPropsFromJson(json);
}
