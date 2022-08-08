import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gato/gato.dart' as gato;
import 'package:get_it/get_it.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';
import 'package:eventify/eventify.dart' as eventify;
import 'package:the_tool/page_utils/style_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super();
  Map<String, String> _staticContent = {};
  static Map<String, dynamic> emptyMapStringDynamic =
      Map<String, dynamic>.from({});
  static final regexPattern = RegExp(r"[^{{\}}]+(?=}})");
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
    Map<String, dynamic> pageContextData,
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

        var bindingData = gato.get(pageContextData, bindingField) ?? "";

        // if (bindingData == null) {
        //   var contextData = getIt<ContextStateProvider>().contextData;
        //   bindingData = gato.get(contextData, bindingField);
        // }

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
    Map<String, dynamic> pageContextData,
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

        var bindingData = gato.get(
          pageContextData,
          bindingField,
        );

        // if (bindingData == null) {
        //   var contextData = getIt<ContextStateProvider>().contextData;
        //   bindingData = gato.get(contextData, bindingField);
        // }

        computedValue = bindingData;
      }
    });

    return computedValue;
  }

  static isFalsy(dynamic data) =>
      ["", "false", "null", "0", "undefined", null, false].contains(data);

  LayoutProps computeWidgetProps(
    LayoutProps content,
    Map<String, dynamic> contextData,
  ) {
    var hidden = bindingValueToProp(
      contextData,
      content.hidden,
    );

    if (!UtilsManager.isFalsy(hidden)) {
      return const LayoutProps(hidden: true);
    }

    LayoutProps? widgetProps =
        themeProvider.mergeClasses(content, contextData) ?? const LayoutProps();

    if (widgetProps.color != null) {
      widgetProps = widgetProps.copyWith(
        color: parseColor(
          widgetProps.color,
          contextData,
        ),
      );
    }

    if (widgetProps.backgroundColor != null) {
      var backgroundColor = widgetProps.backgroundColor;
      var isBindingValue = UtilsManager.isValueBinding(backgroundColor);
      widgetProps = widgetProps.copyWith(
        backgroundColor: parseColor(
          isBindingValue
              ? bindingValueToProp(
                  contextData,
                  backgroundColor,
                )
              : backgroundColor,
          contextData,
        ),
      );
    }

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
      widgetProps = widgetProps.copyWith(
        text: bindingValueToText(
          contextData,
          widgetProps.text,
        ),
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

    if (widgetProps.type == "container") {
      widgetProps = _computeHeightAndWidth(widgetProps, contextData);
    }

    return widgetProps;
  }

  LayoutProps _computeHeightAndWidth(
    LayoutProps widgetProps,
    Map<String, dynamic> contextData,
  ) {
    double? heightResult;
    double? widthResult;

    dynamic maxHeight = widgetProps.maxHeight;
    dynamic maxWidth = widgetProps.maxWidth;
    dynamic minHeight = widgetProps.minHeight;
    dynamic minWidth = widgetProps.minWidth;

    dynamic height = widgetProps.height;
    dynamic width = widgetProps.width;

    double maxHeightResult =
        _computeValue(maxHeight, contextData) ?? double.infinity;
    double maxWidthResult =
        _computeValue(maxWidth, contextData) ?? double.infinity;
    double minHeightResult = _computeValue(minHeight, contextData) ?? 0.0;
    double minWidthResult = _computeValue(minWidth, contextData) ?? 0.0;

    heightResult = _computeValue(height, contextData);
    widthResult = _computeValue(width, contextData);

    assert(
      heightResult is num || heightResult == null,
      "\"height\" must be a number or bound with number value ($height)",
    );

    assert(
      widthResult is num || widthResult == null,
      "\"width\" must be a number or bound with number value ($width)",
    );

    return widgetProps.copyWith(
      height: heightResult,
      width: widthResult,
      maxHeight: maxHeightResult,
      maxWidth: maxWidthResult,
      minHeight: minHeightResult,
      minWidth: minWidthResult,
    );
  }

  dynamic _getBindingValue(
    String rawBind,
    Map<String, dynamic> contextData,
  ) {
    if (UtilsManager.isValueBinding(rawBind)) {
      return bindingValueToProp(contextData, rawBind);
    }
    return rawBind;
  }

  dynamic _computeValue(
    dynamic value,
    Map<String, dynamic> contextData,
  ) {
    if (value is String) {
      return _getBindingValue(value, contextData);
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
    void Function(String bindingString) updateWidgetBindingStrings,
  ) {
    var result = false;
    uncomputedProps.toJson().forEach((propName, value) {
      if (value != null) {
        if (![
          "child",
          "children",
          "computedComponentProps",
        ].contains(propName)) {
          String valueAsString = (value is Map || value is List)
              ? jsonEncode(value)
              : value.toString();
          if (propName == "name") {
            result = true;
          } else if (isValueBinding(valueAsString)) {
            result = true;
          }

          if (result) {
            UtilsManager.regexPattern.allMatches(valueAsString).map(
              (match) {
                var bindString = valueAsString
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
        }
      }
    });

    return result;
  }
}
