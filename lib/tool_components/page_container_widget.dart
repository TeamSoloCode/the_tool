import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    deferred as webview;
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  bool _isWebViewReady = false;
  final UtilsManager _utils = getIt<UtilsManager>();
  final APIClientManager _apiClient = getIt<APIClientManager>();
  String? _errorMessage;
  var _headlessWebView;
  ThemeData? _themeData;
  ThemeMode? _currentThemeMode;

  late EvalJS _evalJS;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    getIt<StorageManager>().closeStorageBox();
    _headlessWebView?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      (ThemeProvider theme) {
        if (_currentThemeMode != theme.currentThemeMode) {
          _updateTheme();
        }
        _currentThemeMode = theme.currentThemeMode;
        return theme.currentThemeMode;
      },
    );
    return MaterialApp(
      theme: _themeData,
      themeMode: _currentThemeMode,
      routes: _computeRoutes(),
      home: FutureBuilder<bool>(
        builder: (context, snapshot) {
          const loadingPage = Scaffold(
            body: Center(child: Text("Loading...")),
          );

          if (snapshot.data == true) {
            if (_errorMessage != null) {
              return Center(
                child: Text(
                  _errorMessage ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (!kIsWeb) {
              _initWebViewForMobile(context);
              if (!_isWebViewReady) {
                _headlessWebView?.dispose();
                _headlessWebView?.run();
              }
            } else {
              _updateWebEvalContext(context);
            }

            return Stack(
              children: [
                if (!_isWebViewReady) loadingPage,
                if (_isWebViewReady || kIsWeb)
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
      supportedLocales: const [
        Locale('en'),
      ],
      localizationsDelegates: const [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
    );
  }

  Future<bool> _isReadyToRun() async {
    return Future<bool>.microtask(() async {
      await getIt<StorageManager>().initStorageBox();

      if (!kIsWeb) {
        await webview.loadLibrary();
        await getIt<UtilsManager>().loadStaticContent();
      }

      return true;
    });
  }

  Future<void> _updateTheme() async {
    var themePath = getIt<ContextStateProvider>().appConfig?.themePath;
    Map<String, dynamic> theme = await _apiClient.getAppTheme(
      themePath: themePath,
    );
    var currentThemeData =
        await context.read<ThemeProvider>().computeThemeData(theme);

    setState(() {
      _themeData = currentThemeData;
    });
  }

  Map<String, Widget Function(BuildContext)> _computeRoutes() {
    var config = context.read<ContextStateProvider>().appConfig;
    var routeConfig = config?.routes;
    if (routeConfig == null) return {};

    Map<String, Widget Function(BuildContext)> routes = {};
    List<Map<String, dynamic>> routesConfig = routeConfig;

    for (var routeConfig in routesConfig) {
      String path = routeConfig['path'];
      routes.addAll({
        "/$path": (context) => T_Page(pagePath: path),
      });
    }

    return routes;
  }

  String _getInitialPage() {
    var config = context.read<ContextStateProvider>().appConfig;
    String? initialPage = config?.initialPage;

    if (initialPage == null || initialPage == "") {
      setState(() {
        _errorMessage = "Missing initial page path in config";
      });
      return "";
    }

    return initialPage;
  }

  void _updateWebEvalContext(BuildContext context) {
    _evalJS = EvalJS(
      contextStateProvider: context.read<ContextStateProvider>(),
      context: context,
    );
    _utils.evalJS = _evalJS;
  }

  void _initWebViewForMobile(BuildContext context) {
    _headlessWebView = webview.HeadlessInAppWebView(
      onWebViewCreated: (webViewController) async {
        _evalJS = EvalJS(
          context: context,
          webViewController: webViewController,
          contextStateProvider: context.read<ContextStateProvider>(),
        );

        String clientCore = await _apiClient.getClientCore();
        String htmlContent =
            (await _evalJS.setupReactForClientCode(clientCore));

        await webViewController.loadData(data: htmlContent);

        _utils.evalJS = _evalJS;
      },
      onLoadStart: (controller, url) {},
      androidOnPermissionRequest: (controller, origin, resources) async {
        return webview.PermissionRequestResponse(
          resources: resources,
          action: webview.PermissionRequestResponseAction.GRANT,
        );
      },
      onLoadStop: (controller, url) async {
        setState(() {
          _isWebViewReady = true;
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
