import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

class BaseEvalJS {
  String _jsResult = '';
  Map<String, dynamic> _nextPageState = {};
  Map<String, dynamic> _prevPageState = {};
  Map<String, dynamic> _initPageState = {};
  bool _didMount = false;
  String _execCodeWithouLibs = "";

  String _baseJS = "";
  String _libJS = "";
  String _pageCode = "";
  Map<String, dynamic> _pageLayout = {};

  String _executedJS = "";
  late JavascriptRuntime jsRuntime = getJavascriptRuntime();

  BaseEvalJS();

  Future<void> _evaluateJSContext() async {
    jsRuntime.onMessage('__set_state__', (dynamic args) {
      _prevPageState.addAll(_nextPageState);
      _nextPageState.addAll(args);
    });

    jsRuntime.onMessage("__init_state__", (dynamic args) {
      _initPageState.addAll(args);
      _prevPageState.addAll(args);
      _nextPageState.addAll(args);
    });

    jsRuntime.onMessage("__set_interval__", (dynamic args) {
      print(args);
      var timer;
      timer = Timer(new Duration(seconds: args["duration"]), () async {
        await _evaluateJsCode(args["fnName"]);
        timer.cancel();
      });
    });

    String contextJS = """
var _didMount = $_didMount;
var _prevState = JSON.parse('${jsonEncode(_prevPageState)}');
var _state = JSON.parse('${jsonEncode(_nextPageState)}');
var _initState = JSON.parse('${jsonEncode(_initPageState)}');
          """;

    jsRuntime.evaluate(_libJS);
    jsRuntime.evaluate(contextJS + _baseJS);

    await jsRuntime.evaluateAsync(contextJS + _pageCode);
  }

  Future<JsEvalResult> _evaluateJsCode(String evalString) async {
    try {
      // jsRuntime = getJavascriptRuntime();

      String contextJS = """
var _didMount = $_didMount;
var _prevState = JSON.parse('${jsonEncode(_prevPageState)}');
var _state = JSON.parse('${jsonEncode(_nextPageState)}');
var _initState = JSON.parse('${jsonEncode(_initPageState)}');
          """;
      _execCodeWithouLibs = contextJS + _pageCode + evalString;
      JsEvalResult jsResult =
          await jsRuntime.evaluateAsync(_execCodeWithouLibs);

      await jsRuntime.evaluateAsync("""onDidUpdate(
              JSON.parse('${jsonEncode(_nextPageState)}'), 
              JSON.parse('${jsonEncode(_prevPageState)}')
            )""");

      // if (evalString != "") {
      //   await jsRuntime.evaluateAsync(contextJS + _pageCode);
      // }

      return Future.value(jsResult);
    } on PlatformException catch (e) {
      print('ERRO: ${e}');
      return Future.value(e.details);
    }
  }
}
