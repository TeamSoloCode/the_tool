import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

part 'data_cell_props.freezed.dart';
part 'data_cell_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class DataCellProps with _$DataCellProps {
  factory DataCellProps({
    required LayoutProps child,
    @Default(false) bool placeholder,
    @Default(false) bool showEditIcon,
    String? onTap,
    String? onLongPress,
    String? onTapDown,
    String? onDoubleTap,
    String? onTapCancel,
  }) = _DataCellProps;

  factory DataCellProps.fromJson(Map<String, Object?> json) =>
      _$DataCellPropsFromJson(json);
}
