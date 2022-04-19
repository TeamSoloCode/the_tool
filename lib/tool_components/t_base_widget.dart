import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class T_BaseWidget extends StatefulWidget {
  const T_BaseWidget({Key? key}) : super(key: key);

  @override
  State<T_BaseWidget> createState() => _T_BaseWidgetState();
}

class _T_BaseWidgetState extends State<T_BaseWidget> {
  Map<String, dynamic> _nextPageState = {};
  Map<String, dynamic> _prevPageState = {};
  Map<String, dynamic> _initPageState = {};

  String _pageCode = "";
  Map<String, dynamic> _pageLayout = {};

  WebViewController? _webViewController;
  bool isWebViewReady = false;

  @override
  void initState() {
    (() async {
      await _loadPage("");
    })();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadPage(String pageName) async {
    String pageCode = await rootBundle.loadString('js-module/test_js.js');
    String pageLayout = await rootBundle.loadString('js-module/test_json.json');

    setState(() {
      _pageCode = pageCode;
      _pageLayout.addAll(jsonDecode(pageLayout));
    });
  }

  Future<void> _executeJS(String js) async {
    if (!isWebViewReady) {
      throw Exception("Web View is not ready yet");
    }

    _webViewController?.runJavascript("context.$js");
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
              children: [
                SizedBox(
                  width: 0,
                  height: 0,
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated:
                        (WebViewController webViewController) async {
                      _webViewController = webViewController;
                      setState(() {
                        isWebViewReady = true;
                      });
                      String fileContent = await rootBundle
                          .loadString('js-module/src/index.html');

                      String replacedContent = fileContent.replaceAll(
                        "// <Client Code>",
                        _pageCode,
                      );
                      _webViewController?.loadUrl(Uri.dataFromString(
                              replacedContent,
                              mimeType: 'text/html',
                              encoding: Encoding.getByName('utf-8'))
                          .toString());
                    },
                    javascriptChannels: <JavascriptChannel>{
                      JavascriptChannel(
                        name: 'messageHandler',
                        onMessageReceived: (JavascriptMessage message) {
                          print(
                              "message from the web view=\"${message.message}\"");
                        },
                      )
                    },
                  ),
                ),
                if (isWebViewReady)
                  T_Widgets(
                    layout: _pageLayout,
                    executeJS: _executeJS,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
