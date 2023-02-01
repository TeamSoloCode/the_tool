import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

part 'layout_builder_item_props.freezed.dart';
part 'layout_builder_item_props.g.dart';

@Freezed(equal: false, toStringOverride: false)
class T_LayoutBuilderItemProps with _$T_LayoutBuilderItemProps {
  const factory T_LayoutBuilderItemProps({
    LayoutProps? child,
    dynamic maxHeight,
    dynamic minHeight,
    dynamic maxWidth,
    dynamic minWidth,
    dynamic className,
    bool? isDefault,
  }) = _T_LayoutBuilderItemProps;

  factory T_LayoutBuilderItemProps.fromJson(Map<String, Object?> json) =>
      _$T_LayoutBuilderItemPropsFromJson(json);
}
