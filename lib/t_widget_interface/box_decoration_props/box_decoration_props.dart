import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/border_props/border_props.dart';

part 'box_decoration_props.freezed.dart';
// part 'box_decoration_props.g.dart';

@freezed
class BoxDecorationProps with _$BoxDecorationProps {
  const factory BoxDecorationProps({
    BorderProps? borderProps,
  }) = _BoxDecorationProps;
  // factory BoxDecorationProps.fromJson(Map<String, Object?> json) =>
  //     _$BoxDecorationPropsFromJson(json);
}
