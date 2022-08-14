import 'package:flutter/rendering.dart';
import 'package:the_tool/t_widget_interface/base_props/base_border_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'border_props.freezed.dart';
part 'border_props.g.dart';

@freezed
class BorderProps with _$BorderProps {
  factory BorderProps(
      {int? width,
      String? color,
      String? style,
      Map<String, dynamic>? left,
      Map<String, dynamic>? right,
      Map<String, dynamic>? bottom,
      Map<String, dynamic>? top}) = _BorderProps;
  factory BorderProps.fromJson(Map<String, Object?> json) =>
      _$BorderPropsFromJson(json);

  // Map<String, dynamic> toJson() => _$BorderPropsToJson(this);
}
