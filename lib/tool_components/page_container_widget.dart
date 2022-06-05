import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  bool isWebViewReady = false;
  UtilsManager utils = getIt<UtilsManager>();
  late EvalJS _evalJS;

  late PullToRefreshController pullToRefreshController;
  final GlobalKey webViewKey = GlobalKey();

  APIClientManager apiClient = getIt<APIClientManager>();
  String? errorMessage;
  HeadlessInAppWebView? headlessWebView;
  ThemeData? themeData;

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
    var currentThemeMode =
        context.select((ThemeProvider theme) => theme.currentThemeMode);
    log("abcd currentTheme $currentThemeMode");
    return MaterialApp(
      theme: themeData,
      // themeMode: currentThemeMode,
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

            if (kIsWeb) _loadWebCoreJSCode(context);

            return Stack(
              children: [
                if (!isWebViewReady) loadingPage,
                if (isWebViewReady)
                  T_Page(
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
    return Future<bool>.microtask(() async {
      Map<String, dynamic> config = await apiClient.getClientConfig();
      Map<String, dynamic> theme = await apiClient.getAppTheme();

      context.read<ContextStateProvider>().appConfig = config;
      await getIt<StorageManager>().initStorageBox();
      themeData = await context.read<ThemeProvider>().computeThemeData(theme);
      // await _updateTheme();
      if (!kIsWeb) {
        await getIt<UtilsManager>().loadStaticContent();
      }

      return true;
    });
  }

  Future<void> _updateTheme() async {
    Map<String, dynamic> theme = await apiClient.getAppTheme();
    var currentThemeData =
        await context.read<ThemeProvider>().computeThemeData(theme);
    setState(() {
      themeData = currentThemeData;
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
        path: (context) => T_Page(pagePath: path),
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
