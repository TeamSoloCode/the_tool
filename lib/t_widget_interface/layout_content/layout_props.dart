import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/app_bar_props/app_bar_props.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';

part 'layout_props.freezed.dart';
part 'layout_props.g.dart';

@Freezed()
class LayoutProps with _$LayoutProps {
  const factory LayoutProps({
    String? type,
    String? color,
    String? backgroundColor,
    String? text,
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
    int? flex,
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
    LayoutProps? child,
    LayoutProps? content,
    List<LayoutProps>? children,
    BottomNavigationProps? bottomNav,
    AppBarProps? appBar,
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
        if (![
          "child",
          "children",
          "componentProps", // this need to stay the same from the begining
        ].contains(key)) {
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
      type: other.type ?? type,
      color: other.color ?? color,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      text: other.text ?? text,
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
      componentProps: other.componentProps ?? componentProps,
      computedComponentProps:
          other.computedComponentProps ?? computedComponentProps,
      sliverListType: other.sliverListType ?? sliverListType,
      itemExtent: other.itemExtent ?? itemExtent,
    );
  }
}
