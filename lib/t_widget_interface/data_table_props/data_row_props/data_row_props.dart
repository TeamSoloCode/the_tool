import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_cell_props/data_cell_props.dart';

part 'data_row_props.freezed.dart';
part 'data_row_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class DataRowProps with _$DataRowProps {
  factory DataRowProps({
    @Default(false) bool selected,
    String? onSelectChanged,
    String? onLongPress,
    String? color,
    required List<DataCellProps> cells,
  }) = _DataRowProps;

  factory DataRowProps.fromJson(Map<String, Object?> json) =>
      _$DataRowPropsFromJson(json);
}
