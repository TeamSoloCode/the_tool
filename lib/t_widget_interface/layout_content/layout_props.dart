import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/app_bar_props/app_bar_props.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';
import 'package:the_tool/t_widget_interface/image_content/image_provider.dart';
import 'package:the_tool/utils.dart';

part 'layout_props.freezed.dart';
part 'layout_props.g.dart';

@Freezed()
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
    dynamic items,
    String? fieldType,
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
    LayoutProps? child,
    LayoutProps? content,
    List<LayoutProps>? children,
    BottomNavigationProps? bottomNav,
    AppBarProps? appBar,
    ImageProviderProps? imageProviderProps,
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
            json.decode(json.encode(value)),
          ));
        }
      }
    });

    return merge(LayoutProps.fromJson(newProps));
  }

  LayoutProps merge(LayoutProps? other) {
    if (other == null) return this;

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
      children: other.children ?? children,
      bottomNav: other.bottomNav ?? bottomNav,
      appBar: other.appBar ?? appBar,
      componentProps: {
        ...{...componentProps ?? UtilsManager.emptyMapStringDynamic},
        ...{...other.componentProps ?? UtilsManager.emptyMapStringDynamic},
      },
      computedComponentProps: {
        ...{...computedComponentProps ?? UtilsManager.emptyMapStringDynamic},
        ...{
          ...other.computedComponentProps ?? UtilsManager.emptyMapStringDynamic
        },
      },
      sliverListType: other.sliverListType ?? sliverListType,
      itemExtent: other.itemExtent ?? itemExtent,
    );
  }
}
