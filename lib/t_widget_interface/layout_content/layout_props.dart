import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
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
import 'package:the_tool/utils.dart';

part 'layout_props.freezed.dart';
part 'layout_props.g.dart';

@Freezed(equal: false)
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
    dynamic className,
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

    /**
     * 
     */
    String? sliverListType,
    double? itemExtent,
    /**
     * This is raw props passed form parent layout to t_component
     * It contains binding value and raw binding value ("{{}}", "@", "!")
     */
    Map<String, dynamic>? componentProps,
    /**
     * This is the props passed from parent layout to t_component
     * It has been bound all the binding value to context data value
     */
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
    String? suffixIcon,
    String? onClickSuffixIcon,
    String? suffixIconColor,
    String? suffixText,
    String? prefixIcon,
    String? onClickPrefixIcon,
    String? prefixIconColor,
    String? prefixText,
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
    LayoutProps? head,
    LayoutProps? body,
    // Expansion End==================================================

    // ListTile Start================================================
    LayoutProps? leading,
    LayoutProps? title,
    LayoutProps? trailing,
    LayoutProps? subtitle,
    double? horizontalTitleGap,
    // ListTile End==================================================

    String? component,
    LayoutProps? child,
    LayoutProps? content,
    LayoutProps? itemLayout,
    List<LayoutProps>? children,
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

extension MergeLayoutProps on LayoutProps {
  LayoutProps parseCssColors(LayoutProps props) {
    var propsAsJSON = props.toJson();

    Map<String, dynamic> newProps = {};
    propsAsJSON.forEach((key, value) {
      if (value != null) {
        if (key.toLowerCase().contains("color")) {
          newProps[key] = ThemeProvider.transformColorFromCSS(value);
        }

        // computedComponentProps could have css color value
        if (key == "computedComponentProps") {
          newProps[key] =
              Map<String, dynamic>.from(ThemeProvider.transformColorFromCSS(
            value,
          ));
        }
      }
    });

    return merge(LayoutProps.fromJson(newProps));
  }

  List<LayoutProps>? _mergeChildren(
    List<LayoutProps> nextChildren,
    List<LayoutProps>? prevChildren,
  ) {
    final mergedChildren = <LayoutProps>[];
    final prevChildrenMap = Map<int, LayoutProps>.fromEntries(
      prevChildren?.asMap().entries ?? [],
    );

    for (var i = 0; i < nextChildren.length; i++) {
      final child = nextChildren[i];
      final prevChild = prevChildrenMap[i];
      if (prevChild != null) {
        mergedChildren.add(prevChild.merge(child));
      }
    }

    final result = <LayoutProps>[];
    final mergedChildrenMap = Map<int, LayoutProps>.fromEntries(
      mergedChildren.asMap().entries,
    );

    for (var i = 0; i < prevChildrenMap.length; i++) {
      final prevChild = prevChildrenMap[i];
      final mergedChild = mergedChildrenMap[i];
      result.add(
          mergedChild != null ? prevChild!.merge(mergedChild) : prevChild!);
    }

    return result;
  }

  LayoutProps merge(LayoutProps? other) {
    if (other == null) return this;
    return copyWith(
      style: other.style ?? style,
      mediaScreenOnly: other.mediaScreenOnly ?? mediaScreenOnly,
      height: other.height ?? height,
      width: other.width ?? width,
      margin: other.margin ?? margin,
      padding: other.padding ?? padding,
      maxWidth: other.maxWidth ?? maxWidth,
      maxHeight: other.maxHeight ?? maxHeight,
      minWidth: other.minWidth ?? minWidth,
      minHeight: other.minHeight ?? minHeight,
      flex: other.flex ?? flex,
      fit: other.fit ?? fit,
      iconSize: other.iconSize ?? iconSize,
      leading: other.leading ?? leading,
      title: other.title ?? title,
      trailing: other.trailing ?? trailing,
      subtitle: other.subtitle ?? subtitle,
      shadowColor: other.shadowColor ?? shadowColor,

      image: other.image ?? image,

      enabled: other.enabled ?? enabled,

      prefixText: other.prefixText ?? prefixText,
      suffixText: other.suffixText ?? suffixText,
      suffixIcon: other.suffixIcon ?? suffixIcon,
      suffixIconColor: other.suffixIconColor ?? suffixIconColor,
      prefixIcon: other.prefixIcon ?? prefixIcon,
      prefixIconColor: other.prefixIconColor ?? prefixIconColor,

      // type: other.type ?? type,
      color: other.color ?? color,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      text: other.text ?? text,
      textAlign: other.textAlign ?? textAlign,
      selectable: other.selectable ?? selectable,
      fontSize: other.fontSize ?? fontSize,
      hidden: other.hidden ?? hidden,
      icon: other.icon ?? icon,
      mainAxisAlignment: other.mainAxisAlignment ?? mainAxisAlignment,
      path: other.path ?? path,
      onClick: other.onClick ?? onClick,
      buttonType: other.buttonType ?? buttonType,
      key: other.key ?? key,
      name: other.name ?? name,
      items: other.items ?? items,
      allowClear: other.allowClear ?? allowClear,
      defaultValue: other.defaultValue ?? defaultValue,
      autovalidateMode: other.autovalidateMode ?? autovalidateMode,
      borderRadius: other.borderRadius ?? borderRadius,
      fieldType: other.fieldType ?? fieldType,
      className: other.className ?? className,
      child: other.child == null
          ? child
          : (child?.merge(other.child) ?? other.child),
      content: other.content ?? content,
      scrollable: other.scrollable ?? scrollable,
      children: other.children == null
          ? children
          : _mergeChildren(other.children!, children),
      bottomNav: other.bottomNav ?? bottomNav,
      obscureText: other.obscureText ?? obscureText,
      appBar: other.appBar ?? appBar,
      hintText: other.hintText ?? hintText,
      labelText: other.labelText ?? labelText,
      alignment: other.alignment ?? alignment,
      gradient: other.gradient ?? gradient,
      // validators: other.validators ?? validators,
      componentProps: {
        ...?componentProps,
        ...?other.componentProps,
      },
      computedComponentProps: {
        ...?computedComponentProps,
        ...?other.computedComponentProps,
      },
      sliverListType: other.sliverListType ?? sliverListType,
      itemExtent: other.itemExtent ?? itemExtent,
    );
  }
}
