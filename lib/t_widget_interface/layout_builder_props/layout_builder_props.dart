import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/layout_builder_item_props/layout_builder_item_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

part 'layout_builder_props.freezed.dart';
part 'layout_builder_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class T_LayoutBuilderProps with _$T_LayoutBuilderProps {
  const factory T_LayoutBuilderProps({
    List<T_LayoutBuilderItemProps>? layouts,
    int? defaultLayoutIndex,
  }) = _T_LayoutBuilderProps;

  factory T_LayoutBuilderProps.fromJson(Map<String, Object?> json) =>
      _$T_LayoutBuilderPropsFromJson(json);
}
