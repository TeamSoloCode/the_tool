import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:the_tool/tool_components/t_test_widget.dart';

class TBaseWidget extends StatefulWidget {
  const TBaseWidget({Key? key}) : super(key: key);

  @override
  State<TBaseWidget> createState() => _TBaseWidgetState();
}

class _TBaseWidgetState extends State<TBaseWidget> {
  String _jsResult = '';
  String _baseJS = "";
  String _libJS = "";
  var _pageState = {};
  var _prevPageState = {};

  String _executedJS = "";
  final String _pageCode = """
  function testFunc(data) {
    return data
  }

  useStateEffect(
    (state) => {
      console.log("abcd useStateEffect abcd", state.abcd);
    },
    ["abcd"]
  );

  useStateEffect(
    (state) => {
      console.log("abcd useStateEffect testData", state.testData);
    },
    ["testData"]
  );

  """;
  late JavascriptRuntime flutterJs;
  @override
  void initState() {
    super.initState();
    _loadLibs();
    flutterJs = getJavascriptRuntime();
  }

  @override
  void dispose() {
    flutterJs.dispose();
    super.dispose();
  }

  Future<void> _loadLibs() async {
    String lodash = await rootBundle.loadString('js/libs/lodash.js');
    String react = await rootBundle.loadString('js/libs/react.js');

    _baseJS = await rootBundle.loadString('js/base.js');
    _libJS = lodash + react;
  }

  Future<JsEvalResult> _evaluateJsCode(String evalString) async {
    try {
      flutterJs.localContext = {"localContext": 123};
      flutterJs = getJavascriptRuntime();

      flutterJs.onMessage('__set_state__', (dynamic args) {
        setState(() {
          _prevPageState.addAll(_pageState);
          _pageState.addAll(args);
        });
      });

      _executedJS = _libJS +
          "let _prevState = JSON.parse('${jsonEncode(_prevPageState)}');\nlet _state = JSON.parse('${jsonEncode(_pageState)}');" +
          _baseJS +
          _pageCode +
          evalString;
      JsEvalResult jsResult = await flutterJs.evaluateAsync(_executedJS);

      if (evalString != "") {
        await _evaluateJsCode("");
      }

      flutterJs.dispose();

      setState(() {
        _prevPageState.addAll(_pageState);
      });

      return Future.value(jsResult);
    } on PlatformException catch (e) {
      print('ERRO: ${e.details}');
      return Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('FlutterJS Example'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Dart State: $_pageState\n'),
                  TTest(
                    executeJS: _evaluateJsCode,
                    widgetProps: const {
                      "onClick": "setState(_state)",
                      "text": "TTest Widget"
                    },
                  ),
                  TextButton(
                    child: const Text("Call testFunc(123)"),
                    onPressed: () async {
                      JsEvalResult? jsResult =
                          await _evaluateJsCode("testFunc(123)");

                      setState(() {
                        _jsResult = jsResult.stringResult;
                      });
                    },
                  ),
                  TextButton(
                    child: const Text("Call setState({abcd: Date.now()})"),
                    onPressed: () async {
                      JsEvalResult? jsResult =
                          await _evaluateJsCode("setState({abcd: Date.now()})");

                      setState(() {
                        _jsResult = jsResult.stringResult;
                      });
                    },
                  ),
                  TextButton(
                    child: const Text("Call setState({testData: Date.now()})"),
                    onPressed: () async {
                      JsEvalResult? jsResult = await _evaluateJsCode(
                          "setState({testData: Date.now()})");

                      setState(() {
                        _jsResult = jsResult.stringResult;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _baseJS + _pageCode,
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
