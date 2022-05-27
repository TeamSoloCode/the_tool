import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/base_widget_container.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

class T_BaseWidget extends StatefulWidget {
  const T_BaseWidget({Key? key}) : super(key: key);

  @override
  State<T_BaseWidget> createState() => _T_BaseWidgetState();
}

class _T_BaseWidgetState extends State<T_BaseWidget> {
  Map<String, dynamic>? _config = {};

  WebViewController? _webViewController;
  bool isWebViewReady = false;
  late UtilsManager utils;
  late EvalJS _evalJS;

  @override
  void initState() {
    (() async {
      APIClientManager apiClient = getIt<APIClientManager>();
      Map<String, dynamic> config = await apiClient.getClientConfig();
      setState(() {
        _config = config;
      });
    })();

    utils = getIt<UtilsManager>();

    super.initState();
  }

  Map<String, Widget Function(BuildContext)> _computeRoutes() {
    if (_config == null || gato.get(_config, "routes") == null) return {};

    Map<String, Widget Function(BuildContext)> routes = {};
    List<Map<String, dynamic>> routesConfig = gato.get(_config, "routes");

    routesConfig.forEach((routeConfig) {
      String path = routeConfig['path'];
      routes.addAll({
        path: (context) => T_BaseWidget_Container(pagePath: path),
      });
    });

    return routes;
  }

  final Future<bool> _isReadyToRun = Future<bool>.microtask(() async {
    if (!kIsWeb) {
      await getIt<UtilsManager>().loadStaticContent();
    }

    return true;
  });

  Widget _initWebViewForMobile(BuildContext context) {
    return SizedBox(
      width: 0,
      height: 0,
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _evalJS = EvalJS(
            context: context,
            webViewController: webViewController,
            contextStateProvider: context.read<ContextStateProvider>(),
          );

          APIClientManager apiClient = getIt<APIClientManager>();
          String clientCore = await apiClient.getClientCore();

          String htmlContent = (await _evalJS.setupReactForClientCode(
            "",
            clientCore,
            "",
          ));

          await webViewController.loadUrl(
            Uri.dataFromString(
              htmlContent,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString(),
          );

          utils.evalJS = _evalJS;
        },
        onPageFinished: (url) {
          setState(() {
            isWebViewReady = true;
          });
        },
        javascriptChannels: utils.registerJavascriptChannel(
          context,
          context.read<ContextStateProvider>(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _computeRoutes(),
      home: FutureBuilder<bool>(
        builder: (context, snapshot) {
          const loadingPage = Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );

          if (snapshot.data == true) {
            return Stack(
              children: [
                if (!kIsWeb) _initWebViewForMobile(context),
                if (!isWebViewReady) loadingPage,
                if (isWebViewReady)
                  T_BaseWidget_Container(
                    pagePath: "test_page",
                  ),
              ],
            );
          }
          return loadingPage;
        },
        future: _isReadyToRun,
      ),
    );
  }
}
