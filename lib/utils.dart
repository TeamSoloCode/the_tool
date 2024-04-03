import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/constants.dart';
import 'package:the_tool/js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/js_utils/web_eval_utils/web_eval_js.dart';
import 'package:eventify/eventify.dart' as eventify;
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.extension.dart';
import 'package:the_tool/t_widget_interface/media_screen_only/media_screen_only.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:collection/collection.dart'
    show DeepCollectionEquality, ListEquality;
import 'package:uuid/uuid.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super() {
    _corePageId = "core_${const Uuid().v4()}";
  }

  final envConfig = getIt<EnvironmentConfig>();
  static const _deepEquals = DeepCollectionEquality();
  static const _listEquals = ListEquality();

  static Map<String, dynamic> emptyMapStringDynamic =
      Map<String, dynamic>.from({});

  static final regexPattern = RegExp(r"[^{{\}}]+(?=}})");
  final invertedRegex = RegExp(r'^!(.+)');
  final boolCastRegex = RegExp(r'^!!(.+)');

  static const parentPrefix = "\$parent";
  static const rootPrefix = "\$root.";
  static const mediaQueryPrefix = "\$mediaQuery.";
  static const themeDataPrefix = "\$themeData.";

  /// This is the path for children widget in a list/table/... to get data from contextData
  static const dataPath = "dataPath";

  late String _corePageId;

  late ThemeProvider themeProvider;

  final eventify.EventEmitter _emitter = eventify.EventEmitter();
  eventify.EventEmitter get emitter => _emitter;

  EvalJS? _evalJS;
  EvalJS? get evalJS => _evalJS;

  set evalJS(EvalJS? evalJS) {
    _evalJS = evalJS;
    themeProvider = getIt<ThemeProvider>();
  }

  String get corePageId => _corePageId;

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

        var bindingData = UtilsManager.get(selectedData, bindingField) ?? "";

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
      Map<String, dynamic> contextData, dynamic propValue,
      {bool isDynamicBoolProp = false}) {
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

        var matchBoolCast = boolCastRegex.firstMatch(bindingField);
        var isBooleanCast = matchBoolCast?.group(1) != null;
        var isInverted = false;

        if (isBooleanCast) {
          bindingField = matchBoolCast!.group(1)!;
        } else {
          var matchInverted = invertedRegex.firstMatch(bindingField);
          isInverted = matchInverted?.group(1) != null;
          if (isInverted) {
            bindingField = matchInverted!.group(1)!;
          }
        }

        var useRootData = bindingField.startsWith(rootPrefix);
        var selectedData = useRootData ? rootData : contextData;

        if (useRootData) {
          bindingField = bindingField.substring(rootPrefix.length);
        }

        var bindingData = UtilsManager.get(selectedData, bindingField);

        computedValue = bindingData;
        if (isInverted || isBooleanCast || isDynamicBoolProp) {
          computedValue = isBooleanCast || isDynamicBoolProp
              ? isTruthy(computedValue)
              : !isTruthy(computedValue);
        }
      }
    });

    return computedValue;
  }

  static bool isTruthy(dynamic data) =>
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

  final _textBindingKeys = {
    "url",
    "key",
  }.cast<String>();

  Map<String, Object?> _bindingWidgetPropValue(
    dynamic propsJson,
    Map<String, dynamic> contextData,
  ) {
    // merge dynamicProps to widget layout json
    var dynamicProps = propsJson["dynamicProps"];
    if (dynamicProps != null && dynamicProps is List) {
      var result = computeDynamicProps(dynamicProps, contextData);
      if (result.isNotEmpty) {
        propsJson.addAll(result);
      }
    }

    var cloneJson = Map<String, dynamic>.from(propsJson);

    propsJson.forEach((key, value) {
      final ignored = ignoredComputeProps[key];
      if (ignored == true) {
        cloneJson[key] = value;
      } else if (value is Map) {
        cloneJson[key] = _bindingWidgetPropValue(value, contextData);
      } else if (value is List) {
        cloneJson[key] = _bindingWidgetPropValueList(value, contextData);
      } else {
        cloneJson[key] = _bindingWidgetPropValueSingle(
          key,
          value,
          contextData,
        );
      }
    });

    return cloneJson;
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

    if (lowercasedKey.contains("color")) {
      if (value is Color) return value;
      return parseColor(value, contextData);
    }

    if (!UtilsManager.isValueBinding(value)) {
      return value;
    }

    if (lowercasedKey.contains("text") ||
        lowercasedKey.contains("click") ||
        key == "onDismissed" ||
        _textBindingKeys.contains(key)) {
      return bindingValueToText(contextData, value);
    }

    return bindingValueToProp(
      contextData,
      value,
      isDynamicBoolProp: dynamicBoolProps.contains(key),
    );
  }

  LayoutProps computeWidgetProps(
    LayoutProps layoutProps,
    Map<String, dynamic> contextData, {
    bool hasBindingValue = true,
  }) {
    var hidden = bindingValueToProp(
      contextData,
      layoutProps.hidden,
    );

    if (UtilsManager.isTruthy(hidden)) {
      return const LayoutProps(hidden: true);
    }

    LayoutProps widgetProps = themeProvider.mergeClasses(
          layoutProps,
          contextData,
        ) ??
        const LayoutProps();

    if (hasBindingValue) {
      var result = _bindingWidgetPropValue(
        widgetProps.toJson(),
        contextData,
      );

      widgetProps = widgetProps.merge(LayoutProps.fromJson(result));
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

      // widgetProps = widgetProps.copyWith(
      //   computedComponentProps: updatedComponentProps,
      // );
    }

    widgetProps = widgetProps.parseCssColors(widgetProps);

    /**
     * Every t_widget that have measure properties should be add
     * to this array to chech for binding data and computing it
     */
    if (twidgetHasSizeProps.contains(widgetProps.type)) {
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
      if (value == "infinity") {
        return double.infinity;
      }

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
    if (rawColor == null) {
      return rawColor;
    }

    if (themeProvider.baseColor?[rawColor] != null) {
      return themeProvider.baseColor?[rawColor];
    }

    if (UtilsManager.isValueBinding(rawColor)) {
      return StyleUtils.getCssStringWithContextData(
        rawColor,
        contextData,
      );
    }

    return rawColor;
  }

  bool hasBindingValue(
    Map widgetPropsAsJSON,
    void Function(String bindingString)? updateWidgetBindingStrings, {
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
    widgetPropsAsJSON.forEach((key, value) {
      if (value == null || ignoredComputeProps[key] == true) {
        return;
      }

      final valueAsString = (value is Map || value is List)
          ? jsonEncode(value)
          : value.toString();

      switch (key) {
        case "name":
        case "value":
          result = true;
          updateWidgetBindingStrings?.call(value);
          break;
        case "style":
          if (value is String) {
            hasThemeBindingValue?.call();
          }
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

            updateWidgetBindingStrings?.call(bindString);
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

  static List<Widget>? computeListTWidgets(
    List<LayoutProps>? widgetProps, {
    required String pagePath,
    required Map<String, dynamic> childData,
  }) {
    if (widgetProps == null) {
      return null;
    }
    var index = 0;

    List<Widget> widgets = [];
    for (var widgetProp in widgetProps) {
      widgets.add(
        TWidgets(
          key: ValueKey(index++),
          layout: widgetProp,
          pagePath: pagePath,
          childData: childData,
        ),
      );
    }

    return widgets;
  }

  static Widget? computeTWidgets(
    LayoutProps? widgetProps, {
    required String pagePath,
    required Map<String, dynamic> childData,
  }) {
    if (widgetProps == null) {
      return null;
    }

    return TWidgets(
      layout: widgetProps,
      pagePath: pagePath,
      childData: childData,
    );
  }

  static Widget applyWrappers(
    LayoutProps? widgetProps,
    Widget child,
  ) {
    if (widgetProps == null) {
      return child;
    }

    var wrappers = widgetProps.wrappers;
    if (wrappers == null || wrappers.isEmpty) {
      return child;
    }

    Widget result = child;

    for (var wrapper in wrappers) {
      switch (wrapper["type"]) {
        case "safe_area":
          result = SafeArea(
            child: result,
          );
          break;
        case "expanded":
          result = Expanded(
            flex: wrapper["flex"] ?? 1,
            child: result,
          );
          break;
        case "flexible":
          result = Flexible(
            flex: wrapper["flex"] ?? 1,
            fit: ThemeDecoder.decodeFlexFit(wrapper["fit"]) ?? FlexFit.loose,
            child: result,
          );
          break;
        case "padding":
          result = Padding(
            padding: ThemeDecoder.decodeEdgeInsetsGeometry(
                  wrapper["padding"],
                ) ??
                const EdgeInsets.all(0),
            child: result,
          );
          break;
        case "align":
          result = Align(
            alignment: ThemeDecoder.decodeAlignment(
                  wrapper["alignment"],
                ) ??
                Alignment.center,
            child: result,
          );
          break;
        case "center":
          result = Center(
            child: result,
          );
          break;
        case "clip_oval":
          result = ClipOval(
            child: result,
          );
          break;
        case "clip_rect":
          result = ClipRect(
            child: result,
          );
          break;
        case "clip_path":
          result = ClipPath(
            child: result,
          );
          break;
      }
    }

    return result;
  }

  static bool isListEquals(List<dynamic> list1, List<dynamic> list2) {
    return _listEquals.equals(list1, list2);
  }

  static bool isEquals(Object? e1, Object? e2) {
    return _deepEquals.equals(e1, e2);
  }

  static DismissDirection getDismissDirectionFromString(
    String? input, {
    DismissDirection defaultValue = DismissDirection.down,
  }) {
    switch (input) {
      case "startToEnd":
        return DismissDirection.startToEnd;
      case "endToStart":
        return DismissDirection.endToStart;
      case "up":
        return DismissDirection.up;
      case "vertical":
        return DismissDirection.vertical;
      case "horizontal":
        return DismissDirection.horizontal;
      case "none":
        return DismissDirection.none;
      default:
        return defaultValue;
    }
  }

  /// This function is used to get data from Map when you have the path as a string
  /// Example: get({"a": {"b": 1}}, "a.b") => 1
  /// Example2: get({"a": [{"b": 1}]}, "a.0.b") => 1
  static T? get<T>(source, String path, {T Function(dynamic)? converter}) {
    final keys = path.split('.');
    dynamic value = source;

    for (final key in keys) {
      if (value is List) {
        final index = int.tryParse(key);
        if (index == null || index >= value.length) {
          return null;
        }
        value = value[index];
      } else if (value is Map) {
        value = value[key];
      } else {
        return null;
      }
    }

    return value == null ? null : (converter?.call(value) ?? value as T);
  }

  static void set(source, String path, dynamic value) {
    final keys = path.split('.');
    dynamic target = source;

    for (final key in keys.skip(0).take(keys.length - 1)) {
      if (target is List) {
        final index = int.tryParse(key);
        if (index == null || index >= target.length) {
          return;
        }
        target = target[index];
      } else if (target is Map) {
        target = target[key];
      } else {
        return;
      }
    }

    if (target is List) {
      final index = int.tryParse(keys.last);
      if (index == null || index >= target.length) {
        return;
      }
      target[index] = value;
    } else if (target is Map) {
      target[keys.last] = value;
    }
  }

  Map<String, bool Function(dynamic, dynamic)> operatorMap = {
    "==": (a, b) => a == b,
    "=": (a, b) => a == b,
    "!=": (a, b) => a != b,
    ">": (a, b) => a > b,
    "<": (a, b) => a < b,
    "<=": (a, b) => a <= b,
    ">=": (a, b) => a >= b,
  };

  bool computeDynamicProp(
    dynamic conditions,
    Map<String, dynamic> contextData,
  ) {
    if (conditions is List) {
      var results = conditions.map((condition) {
        return computeDynamicProp(condition, contextData);
      }).toList();

      bool result = true;
      results.asMap().forEach((index, element) {
        // if the previous element is a list, then we should use OR operator
        if (index > 0 && conditions[index - 1] is List) {
          result = result || element;
        } else {
          result = result && element;
        }
      });

      return result;
    }

    final source = conditions['source'];
    final target = conditions['target'];
    final operator = conditions['operator'];

    if (operator == null) {
      throw Exception(
          'source, target, and operator are required. Error in: $conditions');
    }

    final sourceValue = isValueBinding(source)
        ? bindingValueToProp(contextData, source)
        : source;

    final targetValue = isValueBinding(target)
        ? bindingValueToProp(contextData, target)
        : target;

    final operatorFunction = operatorMap[operator];
    if (operatorFunction != null) {
      // cannot use > < >= <= with null
      if ((sourceValue == null || targetValue == null) &&
          !["==", "!="].contains(operator)) {
        return sourceValue == targetValue;
      }
      return operatorFunction(sourceValue, targetValue);
    }

    return false;
  }

  Map<String, dynamic> computeDynamicProps(
    List<dynamic> dynamicProps,
    Map<String, dynamic> contextData,
  ) {
    var dynamicPropsResults = <Map<String, dynamic>>[];

    for (var dynamicProp in dynamicProps) {
      if (dynamicProp is Map<String, dynamic>) {
        var conditions = dynamicProp["conditions"];
        final switchValue = dynamicProp["switch"];

        if (conditions != null) {
          var result = computeDynamicProp(conditions, contextData);
          dynamicPropsResults.add(dynamicProp[result.toString()] ?? {});
        } else if (switchValue != null) {
          final cases = dynamicProp["cases"] as Map<dynamic, dynamic>?;
          if (cases != null) {
            var parsedSwitchValue = isValueBinding(switchValue)
                ? bindingValueToProp(contextData, switchValue)
                : switchValue;
            dynamicPropsResults.add(cases[parsedSwitchValue] ?? {});
          }
        }
      } else {
        throw Exception(
          "Invalid dynamicProp: $dynamicProp . Only support Map or List of Map",
        );
      }
    }

    var mergedProps = <String, dynamic>{};

    for (var element in dynamicPropsResults) {
      if (element.isNotEmpty) {
        mergedProps.addAll(element);
      }
    }

    return mergedProps;
  }
}
