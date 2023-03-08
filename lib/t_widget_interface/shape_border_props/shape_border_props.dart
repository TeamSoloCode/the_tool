import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/border_side_props/border_side_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/border_radius_props/border_radius_props.dart';

part 'shape_border_props.freezed.dart';
part 'shape_border_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class TShapeBorderProps with _$TShapeBorderProps {
  const factory TShapeBorderProps({
    String? type,
    TBorderSideProps? side,
    BorderRadiusProps? borderRadius,
  }) = _TShapeBorderProps;

  factory TShapeBorderProps.fromJson(Map<String, Object?> json) =>
      _$TShapeBorderPropsFromJson(json);
}
