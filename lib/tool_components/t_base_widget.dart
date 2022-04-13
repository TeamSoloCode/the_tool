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
  var _pageState = {};
  var _prevPageState = {};

  String _baseJS = "";
  String _libJS = "";
  String _pageCode = "";
  Map<String, dynamic> _pageLayout = {};

  String _executedJS = "";
  late JavascriptRuntime flutterJs;

  @override
  void initState() {
    super.initState();
    _loadLibs();
    _loadPage("");
    flutterJs = getJavascriptRuntime();
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
    print("Rerender");
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
                  Text('Dart State: $_pageState\n'),
                  T_Widgets(layout: _pageLayout, executeJS: _evaluateJsCode),
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
