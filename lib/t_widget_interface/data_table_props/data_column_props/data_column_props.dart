import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_column_props.freezed.dart';
part 'data_column_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class DataColumnProps with _$DataColumnProps {
  factory DataColumnProps({
    required String label,
    String? tooltip,
    @Default(false) bool numeric,
    String? onSort,
  }) = _DataColumnProps;

  factory DataColumnProps.fromJson(Map<String, Object?> json) =>
      _$DataColumnPropsFromJson(json);
}