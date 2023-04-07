import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'border_radius_props.freezed.dart';
part 'border_radius_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
// @JsonSerializable()
class BorderRadiusProps with _$BorderRadiusProps {
  factory BorderRadiusProps({
    String? colors,
    double? width,
    String? type,
    double? radius,
    double? left,
    double? right,
    dynamic bottomLeft,
    dynamic bottomRight,
    dynamic topLeft,
    dynamic topRight,
    double? bottom,
    double? top,
    int? blurRadius,
    String? colorBoxShadow,
    int? offset,
    int? spreadRadius,
  }) = _BorderRadiusProps;
  factory BorderRadiusProps.fromJson(Map<String, Object?> json) =>
      _$BorderRadiusPropsFromJson(json);

  // Map<String, dynamic> toJson() => _;
}
