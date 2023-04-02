import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gato/gato.dart' as gato;
import 'package:get_it/get_it.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';
import 'package:eventify/eventify.dart' as eventify;
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/media_screen_only/media_screen_only.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super();
  Map<String, String> _staticContent = {};
  static Map<String, dynamic> emptyMapStringDynamic =
      Map<String, dynamic>.from({});
  static final regexPattern = RegExp(r"[^{{\}}]+(?=}})");
  static const parentPrefix = "\$parent";
  static const rootPrefix = "\$root.";
  static const mediaQueryPrefix = "\$mediaQuery.";
  static const themeDataPrefix = "\$themeData.";
  late ThemeProvider themeProvider;

  final eventify.EventEmitter _emitter = eventify.EventEmitter();
  eventify.EventEmitter get emitter => _emitter;

  EvalJS? _evalJS;
  EvalJS? get evalJS => _evalJS;

  set evalJS(EvalJS? evalJS) {
    _evalJS = evalJS;
    themeProvider = getIt<ThemeProvider>();
  }

  Future<void> loadStaticContent() async {
    List<String> content = await Future.wait<String>(
      [
        rootBundle.loadString('js-module/dist/vendors.js'),
        rootBundle.loadString('js-module/dist/app.js'),
        rootBundle.loadString('js-module/dist/index.html')
      ],
    );

    _staticContent = {
      "vendor": content[0],
      "app": content[1],
      "htmlContent": content[2]
    };
  }

  Map<String, String> get staticContent => _staticContent;

  static bool isValueBinding(String? value) {
    if (value == null) return false;
    var match = UtilsManager.regexPattern.firstMatch(value);

    if (match != null) {
      return true;
    }

    return false;
  }

  String bindingValueToText(
    Map<String, dynamic> contextData,
    String? text,
  ) {
    if (text is! String) return text ?? "";
    if (!isValueBinding(text)) {
      return text;
    }

    var computedText = text;
    UtilsManager.regexPattern.allMatches(text).forEach((element) {
      var match = UtilsManager.regexPattern.firstMatch(computedText);

      if (match != null) {
        String bindingField = computedText
            .substring(
              match.start,
              match.end,
            )
            .trim();

        var rootData = getIt<ContextStateProvider>().rootPageData;
        var useRootData = bindingField.startsWith(rootPrefix);
        var selectedData = useRootData ? rootData : contextData;

        if (useRootData) {
          bindingField = bindingField.substring(rootPrefix.length);
        }

        var bindingData = gato.get(selectedData, bindingField) ?? "";

        computedText = computedText.replaceRange(
          match.start - 2,
          match.end + 2,
          bindingData.toString(),
        );
      }
    });

    return computedText;
  }

  dynamic bindingValueToProp(
    Map<String, dynamic> contextData,
    dynamic propValue,
  ) {
    if (propValue is! String) return propValue;
    if (!isValueBinding(propValue)) return propValue;

    dynamic computedValue = propValue;
    UtilsManager.regexPattern.allMatches(propValue).forEach((element) {
      var match = UtilsManager.regexPattern.firstMatch(computedValue);

      if (match != null) {
        String bindingField = computedValue
            .substring(
              match.start,
              match.end,
            )
            .trim();

        var rootData = getIt<ContextStateProvider>().rootPageData;
        var useRootData = bindingField.startsWith(rootPrefix);
        var selectedData = useRootData ? rootData : contextData;

        if (useRootData) {
          bindingField = bindingField.substring(rootPrefix.length);
        }

        var bindingData = gato.get(selectedData, bindingField);

        computedValue = bindingData;
      }
    });

    return computedValue;
  }

  static isTruthy(dynamic data) =>
      !["", "false", "null", "0", "undefined", null, false].contains(data);

  LayoutProps computeWidgetProps(
    LayoutProps layoutProps,
    Map<String, dynamic> contextData,
  ) {
    var hidden = bindingValueToProp(
      contextData,
      layoutProps.hidden,
    );

    if (UtilsManager.isTruthy(hidden)) {
      return const LayoutProps(hidden: true);
    }

    LayoutProps? widgetProps =
        themeProvider.mergeClasses(layoutProps, contextData) ??
            const LayoutProps();

    widgetProps = parseAndBindingColor(widgetProps, contextData);
    widgetProps = themeProvider.mergeBaseColor(widgetProps);

    if (widgetProps.icon != null &&
        UtilsManager.isValueBinding(widgetProps.icon)) {
      widgetProps = widgetProps.copyWith(
        icon: bindingValueToText(
          contextData,
          widgetProps.icon,
        ),
      );
    }

    if (widgetProps.text != null &&
        UtilsManager.isValueBinding(widgetProps.text)) {
      var text = bindingValueToText(contextData, widgetProps.text);
      widgetProps = widgetProps.copyWith(text: text);
    }

    // if (widgetProps.errorText != null &&
    //     UtilsManager.isValueBinding(widgetProps.errorText)) {
    //   widgetProps = widgetProps.copyWith(
    //     errorText: bindingValueToText(
    //       contextData,
    //       widgetProps.errorText,
    //     ),
    //   );
    // }

    if (widgetProps.defaultValue != null &&
        UtilsManager.isValueBinding(widgetProps.defaultValue)) {
      widgetProps = widgetProps.copyWith(
        defaultValue: bindingValueToProp(
          contextData,
          widgetProps.defaultValue,
        ),
      );
    }

    if (UtilsManager.isValueBinding(widgetProps.selected)) {
      var selected = UtilsManager.isTruthy(
        bindingValueToProp(
          contextData,
          widgetProps.selected,
        ),
      );

      widgetProps = widgetProps.copyWith(selected: selected);
    }

    if (UtilsManager.isValueBinding(widgetProps.image?.url)) {
      var newImage = widgetProps.image?.copyWith(
        url: bindingValueToProp(
          contextData,
          widgetProps.image?.url,
        ),
      );

      widgetProps = widgetProps.copyWith(
        image: newImage,
      );
    }

    if (widgetProps.type == "component" && widgetProps.componentProps != null) {
      Map<String, dynamic>? updatedComponentProps = {};
      widgetProps.componentProps?.forEach((key, value) {
        var isValueBinding = UtilsManager.isValueBinding(value);
        updatedComponentProps[key] = isValueBinding
            ? bindingValueToProp(
                contextData,
                value,
              )
            : value;
      });

      widgetProps = widgetProps.copyWith(
        computedComponentProps: updatedComponentProps,
      );
    }

    widgetProps = widgetProps.parseCssColors(widgetProps);

    if (["container", "table", "clickable"].contains(widgetProps.type)) {
      widgetProps = computeHeightAndWidth(widgetProps, contextData);
    }

    return widgetProps;
  }

  LayoutProps parseAndBindingColor(
    LayoutProps layoutProps,
    Map<String, dynamic> contextData,
  ) {
    Map<String, String?> unparsedColors = {
      "color": layoutProps.color,
      "backgroundColor": layoutProps.backgroundColor,
      "dividerColor": layoutProps.dividerColor,
      "splashColor": layoutProps.splashColor,
    };
    Map<String, String?> parsedColors = {};

    unparsedColors.forEach((key, color) {
      if (color != null) {
        var isBindingValue = UtilsManager.isValueBinding(color);
        parsedColors[key] = parseColor(
          isBindingValue
              ? bindingValueToProp(
                  contextData,
                  color,
                )
              : color,
          contextData,
        );
      }
    });

    layoutProps = layoutProps.copyWith(
      color: parsedColors["color"],
      backgroundColor: parsedColors["backgroundColor"],
      dividerColor: parsedColors["dividerColor"],
      splashColor: parsedColors["splashColor"],
    );

    return layoutProps;
  }

  double? _parseAdaptiveScreenUnit(String adaptiveUnit) {
    double? computeValue(String unit) {
      var valueAsString = adaptiveUnit.replaceAll(unit, "");
      var value = double.tryParse(valueAsString);
      return value;
    }

    if (adaptiveUnit.endsWith("sw")) {
      return computeValue("sw")?.sw;
    } else if (adaptiveUnit.endsWith("sh")) {
      return computeValue("sh")?.sh;
    } else if (adaptiveUnit.endsWith("w")) {
      return computeValue("w")?.w;
    } else if (adaptiveUnit.endsWith("h")) {
      return computeValue("h")?.h;
    } else if (adaptiveUnit.endsWith("r")) {
      return computeValue("r")?.r;
    } else if (adaptiveUnit.endsWith("sp")) {
      return computeValue("sp")?.sp;
    }

    return 0.0;
  }

  LayoutProps computeHeightAndWidth(
    LayoutProps widgetProps,
    Map<String, dynamic> contextData,
  ) {
    var maxHeight =
        computeSizeValue(widgetProps.maxHeight, contextData) ?? double.infinity;
    var maxWidth =
        computeSizeValue(widgetProps.maxWidth, contextData) ?? double.infinity;
    var minHeight = computeSizeValue(widgetProps.minHeight, contextData) ?? 0.0;
    var minWidth = computeSizeValue(widgetProps.minWidth, contextData) ?? 0.0;

    var height = computeSizeValue(widgetProps.height, contextData);
    var width = computeSizeValue(widgetProps.width, contextData);

    return widgetProps.copyWith(
      height: height,
      width: width,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      minHeight: minHeight,
      minWidth: minWidth,
    );
  }

  dynamic computeSizeValue(
    dynamic value,
    Map<String, dynamic> contextData,
  ) {
    if (value is String) {
      if (UtilsManager.isValueBinding(value)) {
        return bindingValueToProp(contextData, value);
      }
      return _parseAdaptiveScreenUnit(value);
    } else if (value is num) {
      return value / 1.0;
    }
    return value;
  }

  String? parseColor(
    String? rawColor,
    Map<String, dynamic> contextData,
  ) {
    if (rawColor != null && UtilsManager.isValueBinding(rawColor)) {
      return StyleUtils.getCssStringWithContextData(
        rawColor,
        contextData,
      );
    }
    return rawColor;
  }

  bool hasBindingValue(
    LayoutProps uncomputedProps,
    void Function(String bindingString) updateWidgetBindingStrings, {
    void Function()? hasThemeBindingValue,
    void Function()? isPropsHasAdaptiveScreenUnit,
  }) {
    /**
     * type "component" don't need to check for binding value
     * Anh it shouldn't be use with binding value
     */
    if (uncomputedProps.type == "component") {
      return false;
    }

    var result = false;
    uncomputedProps.toJson().forEach((propName, value) {
      if (value == null ||
          propName == "child" ||
          propName == "children" ||
          propName == "computedComponentProps") {
        return;
      }

      if (!["text", "label"].contains(propName) && value is String) {
        var unit = ["sw", "sh", "w", "h", "r", "sp"].firstWhere(
          (unit) => value.endsWith(unit),
          orElse: () => "",
        );

        if (unit.isNotEmpty) {
          isPropsHasAdaptiveScreenUnit?.call();
        }
      }

      final valueAsString = (value is Map || value is List)
          ? jsonEncode(value)
          : value.toString();

      switch (propName) {
        case "name":
        case "value":
          result = true;
          break;
        case "style":
          hasThemeBindingValue?.call();
          break;
        default:
          if (isValueBinding(valueAsString)) {
            result = true;
          }
          break;
      }

      if (result) {
        UtilsManager.regexPattern.allMatches(valueAsString).map(
          (match) {
            final bindString = valueAsString
                .substring(
                  match.start,
                  match.end,
                )
                .trim();
            updateWidgetBindingStrings(bindString);
          },
        ).toList();

        if (propName == "name") {
          updateWidgetBindingStrings(value);
        }
      }
    });

    return result;
  }

  LayoutProps? getMediaScreeStyle(
    MediaQueryData mediaQueryData,
    Map<String, dynamic> contextData,
    List<T_MediaScreenOnlyProps> mediaScreenProps,
  ) {
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;
    var matchMediaScreen = mediaScreenProps.firstWhere(
      (mediaScreen) {
        var maxHeight = mediaScreen.maxHeight;
        var minHeight = mediaScreen.minHeight;
        var maxWidth = mediaScreen.maxWidth;
        var minWidth = mediaScreen.minWidth;

        if (maxHeight != null && maxHeight >= screenHeight) {
          return true;
        } else if (maxWidth != null && maxWidth >= screenWidth) {
          return true;
        } else if (minHeight != null && minHeight <= screenHeight) {
          return true;
        } else if (minWidth != null && minWidth <= screenWidth) {
          return true;
        }

        return false;
      },
      orElse: () => const T_MediaScreenOnlyProps(
        style: null,
      ),
    );

    return matchMediaScreen.style;
  }
}
