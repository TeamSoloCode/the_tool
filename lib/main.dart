import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _jsResult = '';
  String baseJS = "";
  var _pageState = {};
  String _executedJS = "";
  final String _pageCode = """
    function testFunc(data) {
      return data
    }

    useEffect(
      (state) => {
        console.log("abcd useEffect", state);
      },
      [_state["abcd"]]
    );

  """;
  late JavascriptRuntime flutterJs;
  @override
  void initState() {
    super.initState();
    flutterJs = getJavascriptRuntime();
  }

  @override
  void dispose() {
    flutterJs.dispose();
    super.dispose();
  }

  Future<JsEvalResult?> _execJsCode(String evalString) async {
    try {
      baseJS = await rootBundle.loadString('js/base.js');
      flutterJs = getJavascriptRuntime(
        extraArgs: {"initContext": "132 initContext"},
      );

      flutterJs.onMessage('__set_state__', (dynamic args) {
        setState(() {
          _pageState.addAll(args);
        });
      });

      _executedJS = baseJS +
          "initState(${jsonEncode(_pageState)});" +
          _pageCode +
          evalString;
      JsEvalResult jsResult = await flutterJs.evaluateAsync(_executedJS);
      flutterJs.dispose();

      return Future.value(jsResult);
    } on PlatformException catch (e) {
      print('ERRO: ${e.details}');
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
                  Text('JS State: $_jsResult\n'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Dart State: $_pageState\n'),
                  TextButton(
                    child: const Text("Call testFunc(123)"),
                    onPressed: () async {
                      JsEvalResult? jsResult =
                          await _execJsCode("testFunc(123)");

                      setState(() {
                        _jsResult = jsResult?.stringResult ?? "error";
                      });
                    },
                  ),
                  TextButton(
                    child: const Text("Call setState({abcd: Date.now()})"),
                    onPressed: () async {
                      JsEvalResult? jsResult =
                          await _execJsCode("setState({abcd: Date.now()})");

                      setState(() {
                        _jsResult = jsResult?.stringResult ?? "error";
                      });
                    },
                  ),
                  TextButton(
                    child: const Text("Call setState({testData: Date.now()})"),
                    onPressed: () async {
                      JsEvalResult? jsResult =
                          await _execJsCode("setState({testData: Date.now()})");

                      setState(() {
                        _jsResult = jsResult?.stringResult ?? "error";
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _executedJS,
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
