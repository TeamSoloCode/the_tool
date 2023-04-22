import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gato/gato.dart' as gato;
import 'package:get_it/get_it.dart';
import 'package:the_tool/js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/js_utils/web_eval_utils/web_eval_js.dart';
import 'package:eventify/eventify.dart' as eventify;
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/media_screen_only/media_screen_only.dart';
import 'package:the_tool/config/config.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super();
  final envConfig = getIt<EnvironmentConfig>();

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

  static bool isValueBinding(dynamic value) {
    if (value == null) return false;
    if (value is! String) return false;

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

  /// Convert deep nestest Map<dynamic, dynamic> to Map<String, dynamic>
  static Map<String, dynamic> deepConvertToStringKeyMap(
    Map<dynamic, dynamic> map,
  ) {
    Map<String, dynamic> result = {};

    map.forEach((key, value) {
      if (key is! String) {
        key = key.toString();
      }

      if (value is Map) {
        value = deepConvertToStringKeyMap(value);
      } else if (value is List) {
        value = value.map((item) {
          if (item is Map) {
            return deepConvertToStringKeyMap(item);
          }
          return item;
        }).toList();
      }

      result[key] = value;
    });

    return result;
  }

  // Key that have value LayoutProps type or List<LayoutProps>, shouldn't be binding here
  // It will be binding when it rendering
  final _excludedBindingKeys = {
    "child",
    "children",
    "componentProps",
    "computedComponentProps",
    "className", // This key will be handle by ThemeProvider.mergeClasses function
    "suffixIcon",
    "prefixIcon",
  }.cast<String>();

  final _textBindingKeys = {
    "url",
    "key",
  }.cast<String>();

  Map<String, Object?> _bindingWidgetPropValue(
    dynamic propsJson,
    Map<String, dynamic> contextData,
  ) {
    propsJson.forEach((key, value) {
      if (_excludedBindingKeys.contains(key)) {
        propsJson[key] = value;
      } else if (value is Map) {
        propsJson[key] = _bindingWidgetPropValue(value, contextData);
      } else if (value is List) {
        propsJson[key] = _bindingWidgetPropValueList(value, contextData);
      } else {
        if (UtilsManager.isValueBinding(value)) {
          propsJson[key] = _bindingWidgetPropValueSingle(
            key,
            value,
            contextData,
          );
        }
      }
    });

    return propsJson;
  }

  List<dynamic> _bindingWidgetPropValueList(
    List<dynamic> value,
    Map<String, dynamic> contextData,
  ) {
    return value.map((element) {
      if (element is String && UtilsManager.isValueBinding(element)) {
        return _bindingWidgetPropValue(element, contextData);
      }
      return element;
    }).toList();
  }

  dynamic _bindingWidgetPropValueSingle(
    String key,
    dynamic value,
    Map<String, dynamic> contextData,
  ) {
    final lowercasedKey = key.toLowerCase();
    if (lowercasedKey.contains("text") || _textBindingKeys.contains(key)) {
      return bindingValueToText(contextData, value);
    } else if (lowercasedKey.contains("color")) {
      return parseColor(bindingValueToProp(contextData, value), contextData);
    } else {
      return bindingValueToProp(contextData, value);
    }
  }

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

    const initLayoutProp = LayoutProps();
    LayoutProps? widgetProps =
        themeProvider.mergeClasses(layoutProps, contextData) ?? initLayoutProp;

    widgetProps = themeProvider.mergeBaseColor(widgetProps);

    var result = _bindingWidgetPropValue(
      widgetProps.toJson(),
      contextData,
    );

    var boundValueProps = LayoutProps.fromJson(result);
    widgetProps = widgetProps.merge(boundValueProps);

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

    /**
     * Every t_widget that have measure properties should be add
     * to this array to chech for binding data and computing it
     */
    if (["container", "table", "clickable"].contains(widgetProps.type)) {
      widgetProps = computeHeightAndWidth(widgetProps, contextData);
    }

    return widgetProps;
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
    Map widgetPropsAsJSON,
    void Function(String bindingString) updateWidgetBindingStrings, {
    void Function()? hasThemeBindingValue,
  }) {
    /**
     * type "component" don't need to check for binding value
     * Anh it shouldn't be use with binding value
     */
    if (widgetPropsAsJSON["type"] == "component") {
      return false;
    }

    var result = false;
    widgetPropsAsJSON.forEach((propName, value) {
      if (value == null ||
          propName == "child" ||
          propName == "children" ||
          propName == "computedComponentProps") {
        return;
      }

      final valueAsString = (value is Map || value is List)
          ? jsonEncode(value)
          : value.toString();

      switch (propName) {
        case "name":
        case "value":
          result = true;
          updateWidgetBindingStrings(value);
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
