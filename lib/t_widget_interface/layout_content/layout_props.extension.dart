import 'package:from_css_color/from_css_color.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';

extension MergeLayoutProps on LayoutProps {
  LayoutProps parseCssColors(LayoutProps props) {
    var themeProvider = getIt<ThemeProvider>();

    Map<String, dynamic> newProps = props.toJson().map((key, value) {
      if (value == null) return MapEntry(key, value);

      if (key.toLowerCase().contains('color')) {
        return MapEntry(
          key,
          ThemeProvider.transformColorFromCSS(
            themeProvider.getBaseColorByKey(value),
          ),
        );
      }

      if (key == 'computedComponentProps') {
        return MapEntry(
          key,
          Map<String, dynamic>.from(
            ThemeProvider.transformColorFromCSS(value),
          ),
        );
      }

      return MapEntry(key, value);
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

  String? _mergeColor(String? otherColor, String? color) {
    if (!isCssColor(otherColor ?? "")) return null;
    return otherColor == "" ? color : otherColor;
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
      clipBehavior: other.clipBehavior ?? clipBehavior,

      image: other.image ?? image,

      enabled: other.enabled ?? enabled,
      // Field start======================================
      format: other.format ?? format,
      prefixText: other.prefixText ?? prefixText,
      suffixText: other.suffixText ?? suffixText,
      suffixIcon: other.suffixIcon == null
          ? suffixIcon
          : (suffixIcon?.merge(other.suffixIcon) ?? other.suffixIcon),
      suffixIconColor: other.suffixIconColor ?? suffixIconColor,
      prefixIcon: other.prefixIcon == null
          ? prefixIcon
          : (prefixIcon?.merge(other.prefixIcon) ?? other.prefixIcon),
      prefixIconColor: other.prefixIconColor ?? prefixIconColor,
      // Field end======================================

      // Field Datetime Start =============================='
      initialDate: other.initialDate ?? initialDate,
      lastDate: other.lastDate ?? lastDate,
      firstDate: other.firstDate ?? firstDate,
      // Field Datetime End ================================

      // Dismissible Start================================================

      background: other.background ?? background,
      secondaryBackground: other.secondaryBackground ?? secondaryBackground,
      onDismissed: other.onDismissed ?? onDismissed,

      // Dismissible End==================================================
      // Visibility Start================================================
      visible: other.visible ?? visible,
      maintainState: other.maintainState ?? maintainState,
      maintainAnimation: other.maintainAnimation ?? maintainAnimation,
      maintainSize: other.maintainSize ?? maintainSize,
      // Visibility End==================================================

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
      maxLines: other.maxLines ?? maxLines,
      minLines: other.minLines ?? minLines,

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
      actions: other.actions == null
          ? actions
          : _mergeChildren(other.actions!, actions),
      bottomNav: other.bottomNav ?? bottomNav,
      obscureText: other.obscureText ?? obscureText,
      hintText: other.hintText ?? hintText,
      labelText: other.labelText ?? labelText,
      alignment: other.alignment ?? alignment,
      gradient: other.gradient ?? gradient,
      // validators: other.validators ?? validators,
      wrappers: other.wrappers ?? wrappers,
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
