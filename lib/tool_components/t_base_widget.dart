import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_js.dart';

class T_BaseWidget extends StatefulWidget {
  const T_BaseWidget({Key? key}) : super(key: key);

  @override
  State<T_BaseWidget> createState() => _T_BaseWidgetState();
}

class _T_BaseWidgetState extends State<T_BaseWidget> {
  Map<String, dynamic> _contextData = {};
  Map<String, dynamic> _prevPageState = {};
  Map<String, dynamic> _initPageState = {};

  String _pageCode = "";
  Map<String, dynamic> _pageLayout = {};

  WebViewController? _webViewController;
  bool isWebViewReady = false;
  late UtilsManager utils;
  late EvalJS _evalJS;

  @override
  void initState() {
    (() async {
      await _loadPage(" ");
    })();
    if (kIsWeb) {
      _evalJS = EvalJS(
        contextStateProvider: context.read<ContextStateProvider>(),
      );
    }
    utils = getIt<UtilsManager>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadPage(String pageName) async {
    String pageCode =
        await rootBundle.loadString('js-module/test_data/test_js.js');
    String pageLayout =
        await rootBundle.loadString('js-module/test_data/test_json.json');

    setState(() {
      _pageCode = pageCode;
      _pageLayout.addAll(jsonDecode(pageLayout));
    });
  }

  Future<void> _executeJS(String jsCode) async {
    if (kIsWeb) {
      _evalJS.executeJS(jsCode);
    } else {
      if (!isWebViewReady) {
        throw Exception("Web View is not ready yet");
      }
      _evalJS.executeJS(jsCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('The Tool'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!kIsWeb)
                  SizedBox(
                    width: 0,
                    height: 0,
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated:
                          (WebViewController webViewController) async {
                        _webViewController = webViewController;
                        _evalJS = EvalJS(
                            webViewController: webViewController,
                            contextStateProvider:
                                context.read<ContextStateProvider>());
                        setState(() {
                          isWebViewReady = true;
                        });

                        // TODO: If not have this line, it won't work
                        await Future.delayed(const Duration(milliseconds: 1));

                        String htmlContent =
                            (await utils.composeIndexHTML(_pageCode));
                        _webViewController?.loadUrl(
                          Uri.dataFromString(
                            htmlContent,
                            mimeType: 'text/html',
                            encoding: Encoding.getByName('utf-8'),
                          ).toString(),
                        );
                      },
                      javascriptChannels: utils.registerJavascriptChannel(
                        setState,
                        _contextData,
                        context.read<ContextStateProvider>(),
                      ),
                    ),
                  ),
                Text(" $_contextData"),
                if (isWebViewReady || kIsWeb)
                  T_Widgets(
                    layout: _pageLayout,
                    executeJS: _executeJS,
                    contextData: _contextData,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
