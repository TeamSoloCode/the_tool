import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'border_radius_props.freezed.dart';
part 'border_radius_props.g.dart';

@freezed
// @JsonSerializable()
class BorderRadiusProps with _$BorderRadiusProps {
  factory BorderRadiusProps(
      {String? colors,
      int? width,
      String? type,
      int? radius,
      int? left,
      int? right,
      int? bottomLeft,
      int? bottomRight,
      int? topLeft,
      int? topRight,
      int? bottom,
      int? top,
      int? blurRadius,
      String? colorBoxShadow,
      int? offset,
      int? spreadRadius}) = _BorderRadiusProps;
  factory BorderRadiusProps.fromJson(Map<String, Object?> json) =>
      _$BorderRadiusPropsFromJson(json);

  // Map<String, dynamic> toJson() => _;
}
