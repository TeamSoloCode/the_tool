import 'package:freezed_annotation/freezed_annotation.dart';

part 'clickable_props.freezed.dart';
part 'clickable_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class T_ClickableProps with _$T_ClickableProps {
  const factory T_ClickableProps({
    String? onClick,
  }) = _T_ClickableProps;

  factory T_ClickableProps.fromJson(Map<String, Object?> json) =>
      _$T_ClickablePropsFromJson(json);
}
