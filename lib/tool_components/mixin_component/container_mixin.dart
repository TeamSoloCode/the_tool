import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

mixin ContainerMixin {
  DecorationImage? computeImage(LayoutProps? props) {
    return props?.image != null
        ? ThemeDecoder.decodeDecorationImage({
            "fit": props?.image?.fit,
            "image": props?.image?.toJson(),
          }, validate: false)
        : null;
  }

  BoxBorder? computeBoxBorder(LayoutProps? props) {
    return ThemeDecoder.decodeBoxBorder(props?.boxBorder?.toJson());
  }

  BorderRadiusGeometry? _computeBorderRadius(LayoutProps? props) {
    return props?.borderRadius != null
        ? ThemeDecoder.decodeBorderRadius(props)
        : null;
  }

  BoxShadow? computeBoxShadow(LayoutProps? props) {
    return ThemeDecoder.decodeBoxShadow({
      "blurRadius": props?.boxShadow?.blurRadius,
      // "color": props?.boxShadowProps!.color,
      "offset": props?.boxShadow?.offset,
      "spreadRadius": props?.boxShadow?.spreadRadius,
      "blurStyle": props?.boxShadow?.blurStyle,
    });
  }

  BoxDecoration? computeBoxDecoration(LayoutProps? props) {
    return ThemeDecoder.decodeBoxDecoration({
      "color": props?.backgroundColor,
      //  "backgroundBlendMode": <BlendMode>,
      "border": computeBoxBorder(props),
      "borderRadius": _computeBorderRadius(props),
      "boxShadow": StyleUtils.decodeDynamicList(
        props?.boxShadow != null ? [computeBoxShadow(props)] : [],
      ),
      "image": computeImage(props),
      "gradient": ThemeDecoder.decodeGradient(props?.gradient?.toJson()),
      //  "shape": <BoxShape>
    }, validate: false);
  }

  AlignmentGeometry? computeAlignment(LayoutProps? props) {
    if (props?.alignment == null) return null;
    return ThemeDecoder.decodeAlignment(props?.alignment);
  }
}
