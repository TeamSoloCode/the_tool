import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gato/gato.dart' as gato;
import 'package:get_it/get_it.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  Map<String, String> _staticContent = {};
  var regexPattern = RegExp(r"[^{{\}}]+(?=}})");
  late EvalJS _evalJS;

  UtilsManager() : super() {}

  EvalJS get evalJS => _evalJS;

  set evalJS(EvalJS evalJS) {
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

  bool isValueBinding(String value) {
    var match = regexPattern.firstMatch(value);

    if (match != null) {
      return true;
    }

    return false;
  }

  String bindingValueToString(Map<String, dynamic> contextData, String text) {
    var computedText = text;

    regexPattern.allMatches(text).forEach((element) {
      var match = regexPattern.firstMatch(computedText);

      if (match != null) {
        var bindingData = gato.get(
              contextData,
              computedText.substring(match.start, match.end).trim(),
            ) ??
            "";

        computedText = computedText.replaceRange(
          match.start - 2,
          match.end + 2,
          bindingData.toString(),
        );
      }
    });

    return computedText;
  }

  bool bindingValueToBool(Map<String, dynamic> contextData, String text) {
    var stringResult = bindingValueToString(contextData, text);
    switch (stringResult) {
      case "":
      case "false":
      case "null":
      case "0":
      case "undefined":
        return false;
      default:
        return true;
    }
  }
}
