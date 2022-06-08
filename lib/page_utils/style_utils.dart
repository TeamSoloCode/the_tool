import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:the_tool/utils.dart';

class StyleUtils {
  static UtilsManager _utils = getIt<UtilsManager>();

  static String? getCssStringWithContextData(
    String rawTextColor,
    Map<String, dynamic> contextData,
  ) {
    var isBoundValue = _utils.bindingValueToProp(contextData, rawTextColor);

    if (!UtilsManager.isFalsy(isBoundValue)) {
      var bindingValue = _utils.bindingValueToText(
        contextData,
        rawTextColor,
      );
      if (bindingValue is String && isCssColor(bindingValue)) {
        return fromCssColor(
          bindingValue,
        ).toCssString();
      }
    }

    return null;
  }
}
