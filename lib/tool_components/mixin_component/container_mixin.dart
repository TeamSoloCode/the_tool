import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/t_widget_interface/image_content/image_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';

mixin ContainerMixin {
  DecorationImage? _computeImage(ImageProviderProps? image) {
    if (image == null) return null;

    final imageJson = image.toJson();
    // using image url from project webhost
    if (!imageJson['url'].contains("http")) {
      imageJson['url'] =
          getIt<EnvironmentConfig>().MOBILE_WEBVIEW_URL + imageJson['url'];
    }

    return ThemeDecoder.decodeDecorationImage(
      {
        "fit": image.fit,
        "image": imageJson,
      },
      validate: false,
    );
  }

  BoxBorder? computeBoxBorder(LayoutProps? props) {
    return ThemeDecoder.decodeBoxBorder(props?.boxBorder);
  }

  BoxShadow? computeBoxShadow(LayoutProps? props) {
    return ThemeDecoder.decodeBoxShadow({
      "blurRadius": props?.boxShadow?["blurRadius"],
      "color": props?.boxShadow?["color"],
      "offset": props?.boxShadow?["offset"],
      "spreadRadius": props?.boxShadow?["spreadRadius"],
      "blurStyle": props?.boxShadow?["blurStyle"],
    });
  }

  BoxDecoration? computeBoxDecoration(LayoutProps? props) {
    return ThemeDecoder.decodeBoxDecoration({
      "color": props?.backgroundColor,
      //  "backgroundBlendMode": <BlendMode>,
      "border": computeBoxBorder(props),
      "borderRadius": ThemeDecoder.decodeBorderRadius(props?.borderRadius),
      "boxShadow": StyleUtils.decodeDynamicList(
        props?.boxShadow != null ? [computeBoxShadow(props)] : [],
      ),
      "image": _computeImage(props?.image),
      "gradient": ThemeDecoder.decodeGradient(props?.gradient?.toJson()),
      "shape": ThemeDecoder.decodeBoxShape(props?.shape),
    }, validate: false);
  }
}
