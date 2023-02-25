import 'package:freezed_annotation/freezed_annotation.dart';

part 'gradient_props.freezed.dart';
part 'gradient_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class T_GradientProps with _$T_GradientProps {
  const factory T_GradientProps({
    String? type,
    List<dynamic>? colors,
    dynamic end,
    dynamic begin,
    dynamic stops,
  }) = _T_GradientProps;

  factory T_GradientProps.fromJson(Map<String, Object?> json) =>
      _$T_GradientPropsFromJson(json);
}
