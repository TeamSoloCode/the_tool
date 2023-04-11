import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    deferred as webview;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderLocalizations;
import 'package:the_tool/api_client.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
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

    return MaterialApp.router(
      theme: _themeData,
      themeMode: _currentThemeMode,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en'),
      ],
      localizationsDelegates: const [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      builder: (context, child) {
        return FutureBuilder<bool>(
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

              if (kIsWeb) {
                _updateWebEvalContext(context);
              } else {
                if ([false, null].contains(_headlessWebView?.isRunning())) {
                  _initWebViewForMobile(context);
                  _headlessWebView?.run();
                }
              }

              if (_isWebViewReady || kIsWeb) {
                if (!kIsWeb) {
                  log("Webview: Start render content");
                }

                return child!;
              }
            }
            return loadingPage;
          },
          future: _prepareDependencies(),
        );
      },
    );
  }

  bool _didLoadDeps = false;
  Future<bool> _prepareDependencies() async {
    if (_didLoadDeps) return true;
    if (!kIsWeb) {
      await webview.loadLibrary();
    }
    _didLoadDeps = true;
    return true;
  }

  Future<void> _updateTheme() async {
    var themePath = getIt<ContextStateProvider>().appConfig?.themePath;
    Map<String, dynamic> theme = await _apiClient.getAppTheme(
      themePath: themePath,
    );
    var themeProvider = getIt<ThemeProvider>();
    var currentThemeData = await themeProvider.computeThemeData(theme);

    setState(() {
      _themeData = currentThemeData;
      themeProvider.refreshThemeData();
    });
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
      onWebViewCreated: (webViewController) async {
        if (!kIsWeb) {
          log("Webview: Loading webview start");
        }
      },
      onLoadStart: (controller, url) {},
      androidOnPermissionRequest: (controller, origin, resources) async {
        return webview.PermissionRequestResponse(
          resources: resources,
          action: webview.PermissionRequestResponseAction.GRANT,
        );
      },
      onLoadStop: (webViewController, url) async {
        if (!kIsWeb) {
          log("Webview: Loading webview stop");
        }

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
          rethrow;
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
