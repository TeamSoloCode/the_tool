import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/app_bar_props/app_bar_props.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/border_props/border_props.dart';
import 'package:the_tool/t_widget_interface/shape_border_props/shape_border_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/border_radius_props/border_radius_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/box_shadow_props/box_shadow_props.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_column_props/data_column_props.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_row_props/data_row_props.dart';
import 'package:the_tool/t_widget_interface/drawer_props/drawer_props.dart';
import 'package:the_tool/t_widget_interface/gradient_props/gradient_props.dart';
import 'package:the_tool/t_widget_interface/image_content/image_provider.dart';
import 'package:the_tool/t_widget_interface/layout_builder_props/layout_builder_props.dart';
import 'package:the_tool/t_widget_interface/media_screen_only/media_screen_only.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_prop_metadata.dart';

part 'layout_props.freezed.dart';
part 'layout_props.g.dart';

@Freezed(
  equal: false,
)
class LayoutProps with _$LayoutProps {
  const factory LayoutProps({
    String? type,
    String? color,
    String? backgroundColor,
    String? text,
    double? fontSize,
    dynamic hidden,
    String? icon,
    String? mainAxisAlignment,
    String? path,
    String? buttonType,
    String? key,
    String? name,
    @LayoutPropsMetadata(ignoreComputeProps: true) dynamic className,
    dynamic height,
    dynamic width,
    dynamic maxWidth,
    dynamic maxHeight,
    dynamic minWidth,
    dynamic minHeight,
    dynamic margin,
    dynamic padding,
    double? borderTop,
    double? borderBottom,
    double? borderRight,
    double? borderLeft,
    int? flex,
    Map<String, dynamic>? positioned,
    String? fit,
    double? radius,
    double? iconSize,
    String? shape,
    String? splashColor,
    dynamic alignment,
    double? elevation,
    String? shadowColor,
    double? heightFactor,
    double? widthFactor,
    double? weight,
    dynamic style,
    double? opacity,
    dynamic enabled,
    int? duration,
    dynamic show,
    bool? safeArea,

    /**
     * 
     */
    String? sliverListType,
    double? itemExtent,
    /**
     * This is raw props passed form parent layout to t_component
     * It contains binding value and raw binding value ("{{}}", "@", "!")
     */
    @LayoutPropsMetadata(ignoreComputeProps: true)
        Map<String, dynamic>? componentProps,
    /**
     * This is the props passed from parent layout to t_component
     * It has been bound all the binding value to context data value
     */
    @LayoutPropsMetadata(ignoreComputeProps: true)
        Map<String, dynamic>? computedComponentProps,
    /**
     * Contains json widget for internal layout.json use only
     */
    Map<String, LayoutProps?>? components,
    /**
     * This use to set scroll on Row or Column
     * if scrollable = true and widget is Row => Axix.horizontal
     * if scrollable = true and widget is Column => Axix.vertical
     */
    bool? scrollable,
    T_DrawerProps? drawer,
    T_LayoutBuilderProps? layoutBuilder,
    List<T_MediaScreenOnlyProps>? mediaScreenOnly,

    // Click Properties Start================================================
    String? onClick,
    String? onLongClick,
    String? onDoubleClick,
    String? onClickDown,
    String? onClickUp,
    String? onFocus,
    String? onHover,
    // Click Properties End==================================================

    // Text Start================================================
    String? textAlign,
    bool? selectable,
    // Text Start================================================

    // Field Start==================================================
    String? hintText,
    String? labelText,
    dynamic obscureText,
    dynamic defaultValue,
    dynamic items,
    bool? allowClear,
    String? fieldType,
    bool? numeric,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? suffixIcon,
    String? suffixIconColor,
    String? suffixText,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? prefixIcon,
    String? prefixIconColor,
    String? prefixText,
    String? format,
    String? fillColor,
    /**
     * @summary This function will be eval for validating field value
     * - Return false if value is valid
     * - Return error message if value is invalid
     */
    String? validationFunction,
    /**
     * @summary Enabled/Disabled auto validate on change value
     */
    bool? autovalidate,
    List<Map<String, dynamic>>? validators,
    // Field End==================================================

    // Datetime Field Start==================================================
    String? firstDate,
    String? lastDate,
    String? initialDate,
    // Datetime Field End==================================================

    // Image Picker Start=============================================
    String? onResponse,
    String? host,
    // Image Picker End===============================================

    // Form Start================================================
    String? autovalidateMode,
    // Form End==================================================

    // Table Start================================================
    List<DataColumnProps>? columns,
    List<DataRowProps>? rows,
    String? onSort,
    String? loadDataFunction,
    String? total,
    String? onSelectChanged,
    String? onSelectAll,
    // Table End==================================================

    // Expansion Start================================================
    dynamic selected,
    String? dividerColor,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? head,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? body,
    // Expansion End==================================================

    // ListTile Start================================================
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? leading,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? title,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? trailing,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? subtitle,
    double? horizontalTitleGap,
    // ListTile End==================================================

    String? component,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? child,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? content,
    @LayoutPropsMetadata(ignoreComputeProps: true) LayoutProps? itemLayout,
    @LayoutPropsMetadata(ignoreComputeProps: true) List<LayoutProps>? children,
    BottomNavigationProps? bottomNav,
    AppBarProps? appBar,
    ImageProviderProps? image,
    BorderProps? boxBorder,
    BorderRadiusProps? borderRadius,
    TShapeBorderProps? shapeBorder,
    BoxShadowProps? boxShadow,
    T_GradientProps? gradient,
  }) = _LayoutProps;

  factory LayoutProps.fromJson(Map<String, Object?> json) =>
      _$LayoutPropsFromJson(json);
}
