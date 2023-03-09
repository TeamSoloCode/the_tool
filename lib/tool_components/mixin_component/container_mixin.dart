import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/t_widget_interface/image_content/image_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

mixin ContainerMixin {
  DecorationImage? _computeImage(ImageProviderProps? image) {
    return image != null
        ? ThemeDecoder.decodeDecorationImage(
            {
              "fit": image.fit,
              "image": image.toJson(),
            },
            validate: false,
          )
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
      "image": _computeImage(props?.image),
      "gradient": ThemeDecoder.decodeGradient(props?.gradient?.toJson()),
      "shape": ThemeDecoder.decodeBoxShape(props?.shape),
    }, validate: false);
  }
}
