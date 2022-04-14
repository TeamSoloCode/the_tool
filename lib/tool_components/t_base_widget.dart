import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:the_tool/tool_components/t_widgets.dart';

class T_BaseWidget extends StatefulWidget {
  const T_BaseWidget({Key? key}) : super(key: key);

  @override
  State<T_BaseWidget> createState() => _T_BaseWidgetState();
}

class _T_BaseWidgetState extends State<T_BaseWidget> {
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
  late JavascriptRuntime flutterJs = getJavascriptRuntime();

  @override
  void initState() {
    (() async {
      await _loadLibs();
      await _loadPage("");
      await _evaluateJSContext();
      // eval js for the first time
      await _evaluateJsCode("");
      _didMount = true;
    })();
    super.initState();
  }

  @override
  void dispose() {
    flutterJs.dispose();

    super.dispose();
  }

  Future<void> _loadLibs() async {
    String lodash = await rootBundle.loadString('js/libs/lodash.js');

    _baseJS = await rootBundle.loadString('js/base.js');
    _libJS = lodash;
  }

  Future<void> _evaluateJSContext() async {
    flutterJs.onMessage('__set_state__', (dynamic args) {
      _prevPageState.addAll(_nextPageState);
      _nextPageState.addAll(args);
    });

    flutterJs.onMessage("__init_state__", (dynamic args) {
      _initPageState.addAll(args);
      _prevPageState.addAll(args);
      _nextPageState.addAll(args);
    });

    flutterJs.onMessage("__set_interval__", (dynamic args) {
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

    flutterJs.evaluate(_libJS);
    flutterJs.evaluate(contextJS + _baseJS);

    await flutterJs.evaluateAsync(contextJS + _pageCode);
  }

  Future<void> _loadPage(String pageName) async {
    String pageCode = await rootBundle.loadString('js/test_js.js');
    String pageLayout = await rootBundle.loadString('js/test_json.json');

    setState(() {
      _pageCode = pageCode;
      _pageLayout.addAll(jsonDecode(pageLayout));
    });
  }

  Future<JsEvalResult> _evaluateJsCode(String evalString) async {
    try {
      // flutterJs = getJavascriptRuntime();

      String contextJS = """
var _didMount = $_didMount;
var _prevState = JSON.parse('${jsonEncode(_prevPageState)}');
var _state = JSON.parse('${jsonEncode(_nextPageState)}');
var _initState = JSON.parse('${jsonEncode(_initPageState)}');
          """;
      _execCodeWithouLibs = contextJS + _pageCode + evalString;
      JsEvalResult jsResult =
          await flutterJs.evaluateAsync(_execCodeWithouLibs);

      await flutterJs.evaluateAsync(
          "onDidUpdate(JSON.parse('${jsonEncode(_nextPageState)}'), JSON.parse('${jsonEncode(_prevPageState)}'))");
      // if (evalString != "") {
      //   await flutterJs.evaluateAsync(contextJS + _pageCode);
      // }

      setState(() {
        _prevPageState.addAll(_nextPageState);
      });

      return Future.value(jsResult);
    } on PlatformException catch (e) {
      print('ERRO: ${e}');
      return Future.value(e.details);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('FlutterJS Example'),
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Prev State: $_prevPageState\n'),
                  Text('Next State: $_nextPageState\n'),
                  T_Widgets(layout: _pageLayout, executeJS: _evaluateJsCode),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _execCodeWithouLibs,
                      style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
