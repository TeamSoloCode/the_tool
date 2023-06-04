import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    deferred as webview if (dart.library.html) "";
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderLocalizations;
import 'package:the_tool/api_client.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/route/app_module.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/js_utils/web_eval_utils/web_eval_js.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  bool _isWebViewReady = false;
  final UtilsManager _utils = getIt<UtilsManager>();
  final APIClientManager _apiClient = getIt<APIClientManager>();

  bool _initializedCorePage = false;
  String? _corePageCode;
  String? _errorMessage;
  dynamic _headlessWebView;
  ThemeData? _themeData;
  ThemeMode? _currentThemeMode;

  late Map<String, String> _bundle;

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

    var config = getIt<ContextStateProvider>().appConfig;

    return ModularApp(
      module: AppModule(config!),
      child: MaterialApp.router(
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
      ),
    );
  }

  bool _didLoadDeps = false;
  Future<bool> _prepareDependencies() async {
    if (_didLoadDeps) return true;

    if (!kIsWeb) {
      await webview.loadLibrary();
      if (Platform.isIOS) {
        _bundle = await _apiClient.getAppWebviewBundle();
      }
    }

    _corePageCode = await _apiClient.getClientCore();
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

    _initializeCorePage();
  }

  void _initWebViewForMobile(BuildContext context) {
    if (_isWebViewReady || _headlessWebView != null) return;

    /// This function is help to load js module when developing with is on local machine
    dynamic initialUserScripts;

    initialUserScripts = Platform.isIOS
        ? UnmodifiableListView(
            [
              webview.UserScript(
                source: _bundle["vendor"]!,
                injectionTime:
                    webview.UserScriptInjectionTime.AT_DOCUMENT_START,
              ),
              webview.UserScript(
                source: _bundle["app"]!,
                injectionTime:
                    webview.UserScriptInjectionTime.AT_DOCUMENT_START,
              ),
            ],
          )
        : null;

    _headlessWebView = webview.HeadlessInAppWebView(
      initialUrlRequest: webview.URLRequest(
        url: Uri.parse(getIt<EnvironmentConfig>().MOBILE_WEBVIEW_URL),
      ),
      initialUserScripts: initialUserScripts,
      onWebViewCreated: (webViewController) {},
      onLoadStart: (webViewController, url) async {
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
      },
      androidOnPermissionRequest: (controller, origin, resources) async {
        return webview.PermissionRequestResponse(
          resources: resources,
          action: webview.PermissionRequestResponseAction.GRANT,
        );
      },
      onLoadStop: (webViewController, url) {
        _onLoadWebViewStop();
      },
      onLoadError: (controller, url, code, message) {
        log("\x1B[31m$message\x1B[31m");
      },
      onConsoleMessage: (controller, consoleMessage) {
        log("Webview log: ${consoleMessage.message}");
      },
    );
  }

  Future<void> _onLoadWebViewStop() async {
    await _initializeCorePage();

    setState(() {
      _isWebViewReady = true;
    });
  }

  Future<void> _initializeCorePage() async {
    if (_corePageCode != null && !_initializedCorePage) {
      await _evalJS.executePageCode(
        clientCode: _corePageCode!,
        pagePath: "core",
      );

      _initializedCorePage = true;
    }
  }
}
