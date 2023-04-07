import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    deferred as webview;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderLocalizations;
import 'package:the_tool/api_client.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
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
  dynamic _headlessWebView;
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
    if (_headlessWebView?.isRunning()) {
      _headlessWebView?.dispose();
    }
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
      debugShowCheckedModeBanner: false,
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
            ScreenUtil.init(context);
            if (!kIsWeb) {
              _initWebViewForMobile(context);
              if (!_isWebViewReady) {
                if (_headlessWebView?.isRunning()) {
                  _headlessWebView?.dispose();
                } else {
                  _headlessWebView?.run();
                }
              }
            } else {
              _updateWebEvalContext(context);
            }

            if (_isWebViewReady || kIsWeb) {
              return T_Page(
                pagePath: _getInitialPage(),
              );
            }
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

  bool didMount = false;
  Future<bool> _isReadyToRun() async {
    if (didMount) return true;
    if (!kIsWeb) {
      await webview.loadLibrary();
    }
    didMount = true;
    return true;
  }

  Future<void> _updateTheme() async {
    var themePath = getIt<ContextStateProvider>().appConfig?.themePath;
    Map<String, dynamic> theme = await _apiClient.getAppTheme(
      themePath: themePath,
    );
    var themeProvider = context.read<ThemeProvider>();
    var currentThemeData = await themeProvider.computeThemeData(theme);

    setState(() {
      _themeData = currentThemeData;
      themeProvider.refreshThemeData();
    });
  }

  Map<String, Widget Function(BuildContext)> _computeRoutes() {
    var config = context.read<ContextStateProvider>().appConfig;
    var routeConfig = config?.routes;
    if (routeConfig == null) return {};

    List<Map<String, dynamic>> routesConfig = routeConfig;
    Map<String, Widget Function(BuildContext)> routes = {};

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
      context: context,
    );
    _utils.evalJS = _evalJS;
  }

  void _initWebViewForMobile(BuildContext context) {
    if (_isWebViewReady || _headlessWebView != null) return;

    _headlessWebView = webview.HeadlessInAppWebView(
      initialUrlRequest: webview.URLRequest(
        url: Uri.parse(getIt<EnvironmentConfig>().MOBILE_WEBVIEW_URL),
      ),
      onWebViewCreated: (webViewController) async {},
      onLoadStart: (controller, url) {},
      androidOnPermissionRequest: (controller, origin, resources) async {
        return webview.PermissionRequestResponse(
          resources: resources,
          action: webview.PermissionRequestResponseAction.GRANT,
        );
      },
      onLoadStop: (webViewController, url) async {
        try {
          _evalJS = EvalJS(
            context: context,
            webViewController: webViewController,
          );

          _utils.evalJS = _evalJS;
        } catch (error) {
          _headlessWebView?.dispose();
          _headlessWebView = null;
          _utils.evalJS = null;
          setState(() {
            _isWebViewReady = false;
          });
        }
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
