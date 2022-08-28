import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/app_bar_props/app_bar_props.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/border_props/border_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/border_radius_props/border_radius_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/box_decoration_props.dart';
import 'package:the_tool/t_widget_interface/box_decoration_props/box_shadow_props/box_shadow_props.dart';
import 'package:the_tool/t_widget_interface/image_content/image_provider.dart';
import 'package:the_tool/utils.dart';

part 'layout_props.freezed.dart';
part 'layout_props.g.dart';

@freezed
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
    String? onClick,
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
    double? borderTop,
    double? borderBottom,
    double? borderRight,
    double? borderLeft,
    int? flex,
    String? fit,
    dynamic alignment,
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

    // TextField Start================================================
    String? hintText,
    String? labelText,
    bool? obscureText,
    dynamic items,
    String? fieldType,
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
    // TextField End==================================================

    // Form Start================================================
    String? autovalidateMode,
    // Form End==================================================

    String? component,
    LayoutProps? child,
    LayoutProps? content,
    List<LayoutProps>? children,
    BottomNavigationProps? bottomNav,
    AppBarProps? appBar,
    ImageProviderProps? image,
    BorderProps? boxBorder,
    BorderRadiusProps? borderRadius,
    BoxShadowProps? boxShadow,
  }) = _LayoutProps;

  factory LayoutProps.fromJson(Map<String, Object?> json) =>
      _$LayoutPropsFromJson(json);

  // Map<String, dynamic> toJson() => _$LayoutPropsToJson(this);
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
            json.decode(json.encode(value)),
          ));
        }
      }
    });

    return merge(LayoutProps.fromJson(newProps));
  }

  LayoutProps merge(LayoutProps? other) {
    if (other == null) return this;
    var emptyMapStringDynamic = UtilsManager.emptyMapStringDynamic;
    return copyWith(
      height: other.height ?? height,
      width: other.width ?? width,
      maxWidth: other.maxWidth ?? maxWidth,
      maxHeight: other.maxHeight ?? maxHeight,
      minWidth: other.minWidth ?? minWidth,
      minHeight: other.minHeight ?? minHeight,
      flex: other.flex ?? flex,
      fit: other.fit ?? fit,
      // type: other.type ?? type,
      color: other.color ?? color,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      text: other.text ?? text,
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
      fieldType: other.fieldType ?? fieldType,
      className: other.className ?? className,
      child: other.child ?? child,
      content: other.content ?? content,
      scrollable: other.scrollable ?? scrollable,
      children: other.children ?? children,
      bottomNav: other.bottomNav ?? bottomNav,
      obscureText: other.obscureText ?? obscureText,
      appBar: other.appBar ?? appBar,
      hintText: other.hintText ?? hintText,
      labelText: other.labelText ?? labelText,
      alignment: other.alignment ?? alignment,
      componentProps: other.componentProps != null
          ? {
              ...{...componentProps ?? emptyMapStringDynamic},
              ...{...other.componentProps ?? emptyMapStringDynamic},
            }
          : componentProps,
      computedComponentProps: other.computedComponentProps != null
          ? {
              ...{...computedComponentProps ?? emptyMapStringDynamic},
              ...{...other.computedComponentProps ?? emptyMapStringDynamic},
            }
          : computedComponentProps,
      sliverListType: other.sliverListType ?? sliverListType,
      itemExtent: other.itemExtent ?? itemExtent,
    );
  }
}
