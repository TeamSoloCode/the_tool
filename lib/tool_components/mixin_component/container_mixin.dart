import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

mixin ContainerMixin {
  DecorationImage? computeImage(LayoutProps? props) {
    return props?.imageProviderProps != null
        ? ThemeDecoder.decodeDecorationImage({
            "fit": props?.imageProviderProps?.fit,
            "image": props?.imageProviderProps?.toJson()
          }, validate: false)
        : null;
  }

  BoxBorder? computeBoxBorder(LayoutProps? props) {
    return ThemeDecoder.decodeBoxBorder(props?.boxBorder!.toJson());
  }

  BorderRadiusGeometry? _computeBorderRadius(LayoutProps? props) {
    return props?.borderRadius != null
        ? ThemeDecoder.decodeBorderRadius({
            "type": props?.borderRadius!.type,
            "radius": props?.borderRadius!.radius ?? 0,
            "left": props?.borderRadius!.type == "horizontal"
                ? props?.borderRadius!.left
                : 0,
            "right": props?.borderRadius!.type == "horizontal"
                ? props?.borderRadius!.right
                : 0,
            "bottomLeft": props?.borderRadius!.type == "only"
                ? props?.borderRadius!.bottomLeft
                : 0,
            "bottomRight": props?.borderRadius!.type == "only"
                ? props?.borderRadius!.bottomRight
                : 0,
            "topLeft": props?.borderRadius!.type == "only"
                ? props?.borderRadius!.topLeft
                : 0,
            "topRight": props?.borderRadius!.type == "only"
                ? props?.borderRadius!.topRight
                : 0,
            "bottom": props?.borderRadius!.type == "vertical"
                ? props?.borderRadius!.bottom
                : 0,
            "top": props?.borderRadius!.type == "vertical"
                ? props?.borderRadius!.top
                : 0,
          })
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
      //  "backgroundBlendMode": <BlendMode>,
      "border": computeBoxBorder(props),
      "borderRadius": _computeBorderRadius(props),
      "boxShadow": StyleUtils.decodeDynamicList([computeBoxShadow(props)]),
      "image": computeImage(props),
      //  "gradient": <Gradient>,
      //  "shape": <BoxShape>
    }, validate: false);
  }
}
