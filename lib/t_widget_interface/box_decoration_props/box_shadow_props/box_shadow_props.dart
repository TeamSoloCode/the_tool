import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'box_shadow_props.freezed.dart';
part 'box_shadow_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
// @JsonSerializable()
class BoxShadowProps with _$BoxShadowProps {
  factory BoxShadowProps(
      {String? color,
      int? blurRadius,
      String? blurStyle,
      String? colorBoxShadow,
      Map<String, double>? offset,
      int? spreadRadius}) = _BoxShadowProps;
  factory BoxShadowProps.fromJson(Map<String, Object?> json) =>
      _$BoxShadowPropsFromJson(json);

  // Map<String, dynamic> toJson() => _;
}
