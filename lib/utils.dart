import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:gato/gato.dart' as gato;
import 'package:get_it/get_it.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';
import 'package:eventify/eventify.dart' as eventify;

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super();
  Map<String, String> _staticContent = {};
  static final regexPattern = RegExp(r"[^{{\}}]+(?=}})");

  final eventify.EventEmitter _emitter = eventify.EventEmitter();
  eventify.EventEmitter get emitter => _emitter;

  EvalJS? _evalJS;
  EvalJS? get evalJS => _evalJS;

  set evalJS(EvalJS? evalJS) {
    _evalJS = evalJS;
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

  get staticContent => _staticContent;

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
    if (text == null || !isValueBinding(text)) {
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
}
