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

    if (!UtilsManager.isFalsy(isBoundValue)) {
      var bindingValue = _utils.bindingValueToText(
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
