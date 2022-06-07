import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:the_tool/utils.dart';

class StyleUtils {
  static UtilsManager _utils = getIt<UtilsManager>();

  static String? getCssStringWithContextData(
    String rawTextColor,
    Map<String, dynamic> contextData,
  ) {
    var isBoundValue = _utils.bindingValueToBool(contextData, rawTextColor);

    if (isBoundValue) {
      return fromCssColor(
        _utils.bindingValueToString(
          contextData,
          rawTextColor,
        ),
      ).toCssString();
    }

    return null;
  }
}
