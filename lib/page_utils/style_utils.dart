import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:the_tool/utils.dart';

class StyleUtils {
  static String? getCssStringWithContextData(
    String rawTextColor,
    Map<String, dynamic> contextData,
  ) {
    var isBoundValue =
        UtilsManager.bindingValueToProp(contextData, rawTextColor);

    if (!UtilsManager.isFalsy(isBoundValue)) {
      var bindingValue = UtilsManager.bindingValueToText(
        contextData,
        rawTextColor,
      );
      if (isCssColor(bindingValue)) {
        return fromCssColor(
          bindingValue,
        ).toCssString();
      }
    }

    return null;
  }
}
