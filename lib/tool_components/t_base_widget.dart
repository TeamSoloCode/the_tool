import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/page_context_provider.dart';
import 'package:the_tool/page_utils/storage_utils.dart';
import 'package:the_tool/tool_components/base_widget_container.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

class T_BaseWidget extends StatefulWidget {
  const T_BaseWidget({Key? key}) : super(key: key);

  @override
  State<T_BaseWidget> createState() => _T_BaseWidgetState();
}

class _T_BaseWidgetState extends State<T_BaseWidget> {
  bool isWebViewReady = false;
  UtilsManager utils = getIt<UtilsManager>();
  late EvalJS _evalJS;

  late PullToRefreshController pullToRefreshController;
  final GlobalKey webViewKey = GlobalKey();

  APIClientManager apiClient = getIt<APIClientManager>();
  String? errorMessage;
  HeadlessInAppWebView? headlessWebView;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    getIt<StorageManager>().closeStorageBox();
    headlessWebView?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _computeRoutes(),
      home: FutureBuilder<bool>(
        builder: (context, snapshot) {
          const loadingPage = Scaffold(
            body: Center(child: Text("Loading...")),
          );

          if (snapshot.data == true) {
            if (errorMessage != null) {
              return Center(
                child: Text(
                  errorMessage ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (!kIsWeb) {
              _initWebViewForMobile(context);
              if (!isWebViewReady) {
                headlessWebView?.dispose();
                headlessWebView?.run();
              }
            }

            return Stack(
              children: [
                if (kIsWeb) _loadWebCoreJSCode(context),
                if (!isWebViewReady) loadingPage,
                if (isWebViewReady)
                  T_BaseWidget_Container(
                    pagePath: _getInitialPage(),
                  ),
              ],
            );
          }
          return loadingPage;
        },
        future: _isReadyToRun(),
      ),
    );
  }

  Future<bool> _isReadyToRun() async {
    return await Future<bool>.microtask(() async {
      Map<String, dynamic> config = await apiClient.getClientConfig();
      context.read<ContextStateProvider>().appConfig = config;
      await getIt<StorageManager>().initStorageBox();

      if (!kIsWeb) {
        await getIt<UtilsManager>().loadStaticContent();
      }

      return true;
    });
  }

  Map<String, Widget Function(BuildContext)> _computeRoutes() {
    var config = context.read<ContextStateProvider>().appConfig;
    if (gato.get(config, "routes") == null) return {};

    Map<String, Widget Function(BuildContext)> routes = {};
    List<Map<String, dynamic>> routesConfig = gato.get(config, "routes");

    routesConfig.forEach((routeConfig) {
      String path = routeConfig['path'];
      routes.addAll({
        path: (context) => T_BaseWidget_Container(pagePath: path),
      });
    });

    return routes;
  }

  String _getInitialPage() {
    var config = context.read<ContextStateProvider>().appConfig;
    String? initialPage = gato.get(config, "initialPage");
    if (initialPage == null || initialPage == "") {
      setState(() {
        errorMessage = "Missing initial page path in config";
      });
      return "";
    }

    return initialPage;
  }

  Widget _loadWebCoreJSCode(BuildContext context) {
    if (isWebViewReady) return const SizedBox();

    _evalJS = EvalJS(
      contextStateProvider: context.read<ContextStateProvider>(),
      context: context,
    );
    (() async {
      String clientCore = await apiClient.getClientCore();

      await _evalJS.setupReactForClientCode(
        clientCore,
      );

      utils.evalJS = _evalJS;

      setState(() {
        isWebViewReady = true;
      });
    })();

    return const SizedBox();
  }

  void _initWebViewForMobile(BuildContext context) {
    headlessWebView = HeadlessInAppWebView(
      onWebViewCreated: (webViewController) async {
        _evalJS = EvalJS(
          context: context,
          webViewController: webViewController,
          contextStateProvider: context.read<ContextStateProvider>(),
        );

        String clientCore = await apiClient.getClientCore();
        String htmlContent =
            (await _evalJS.setupReactForClientCode(clientCore));

        await webViewController.loadData(data: htmlContent);

        utils.evalJS = _evalJS;
      },
      onLoadStart: (controller, url) {},
      androidOnPermissionRequest: (controller, origin, resources) async {
        return PermissionRequestResponse(
          resources: resources,
          action: PermissionRequestResponseAction.GRANT,
        );
      },
      onLoadStop: (controller, url) async {
        setState(() {
          isWebViewReady = true;
        });
      },
      onLoadError: (controller, url, code, message) {
        log("\x1B[31m$message\x1B[31m");
      },
      onConsoleMessage: (controller, consoleMessage) {
        log("Webview log: ${consoleMessage.message}");
      },
    );
  }
}
