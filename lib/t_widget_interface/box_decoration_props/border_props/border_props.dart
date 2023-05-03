import 'package:freezed_annotation/freezed_annotation.dart';

part 'border_props.freezed.dart';
part 'border_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class BorderProps with _$BorderProps {
  factory BorderProps({
    String? type,
    int? width,
    String? color,
    String? style,
    Map<String, dynamic>? left,
    Map<String, dynamic>? right,
    Map<String, dynamic>? bottom,
    Map<String, dynamic>? top,
  }) = _BorderProps;
  factory BorderProps.fromJson(Map<String, Object?> json) =>
      _$BorderPropsFromJson(json);

  // Map<String, dynamic> toJson() => _$BorderPropsToJson(this);
}
