import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
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
    Map<String, dynamic>? componentProps,
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
  LayoutProps merge(LayoutProps? other) {
    if (other == null) return this;

    return copyWith(
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
    );
  }
}
