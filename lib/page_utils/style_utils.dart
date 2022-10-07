import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:the_tool/utils.dart';

class StyleUtils {
  static final UtilsManager _utils = getIt<UtilsManager>();

  static String? getCssStringWithContextData(
    String rawTextColor,
    Map<String, dynamic> contextData,
  ) {
    if (!UtilsManager.isValueBinding(rawTextColor) &&
        !isCssColor(rawTextColor)) {
      return null;
    }

    var isBoundValue = _utils.bindingValueToProp(contextData, rawTextColor);

    if (UtilsManager.isTruthy(isBoundValue)) {
      var bindingValue = _utils.bindingValueToText(contextData, rawTextColor);
      if (isCssColor(bindingValue)) {
        return fromCssColor(
          bindingValue,
        ).toCssString();
      }
    }

    return null;
  }

  static List<T>? decodeDynamicList<T>(
    Iterable<T>? list,
  ) {
    return list!.toList();
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.mouse, PointerDeviceKind.touch};
}
