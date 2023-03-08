import 'package:freezed_annotation/freezed_annotation.dart';

part 'border_side_props.freezed.dart';
part 'border_side_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class TBorderSideProps with _$TBorderSideProps {
  const factory TBorderSideProps({
    String? color,
    String? style,
    dynamic width,
  }) = _TBorderSideProps;

  factory TBorderSideProps.fromJson(Map<String, Object?> json) =>
      _$TBorderSidePropsFromJson(json);
}
