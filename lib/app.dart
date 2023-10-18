import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_tool/api/client_api.dart';
import 'package:the_tool/config/prod.dart';
import '' if (dart.library.html) "dart:html";
import 'package:the_tool/js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/js_utils/web_eval_utils/web_eval_js.dart';
import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/static_pages/server_not_found.page.dart'
    deferred as server_not_found;
import 'package:the_tool/tool_components/page_container_widget.dart'
    deferred as page_container;
import 'package:the_tool/static_pages/select_project.page.dart'
    deferred as select_project;
import 'package:the_tool/singleton_register.dart'
    deferred as singleton_register;
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    deferred as webview if (dart.library.html) "";

class TheTool extends StatefulWidget {
  const TheTool({Key? key}) : super(key: key);

  @override
  State<TheTool> createState() => _TheToolState();
}

class _TheToolState extends State<TheTool> {
  String? _selectedProjectName = "built_page";
  String? _cannotLoadConfig;
  final UtilsManager _utils = getIt<UtilsManager>();
  final APIClientManager _apiClient = getIt<APIClientManager>();

  // webview vars
  late EvalJS _evalJS;
  dynamic _headlessWebView;
  late Map<String, String> _bundle;
  // ---------

  @override
  void dispose() {
    getIt<StorageManager>().closeStorageBox();
    if (_headlessWebView?.isRunning()) {
      _headlessWebView?.dispose();
    }
    super.dispose();
  }

  void _loadWebCoreJSCode(BuildContext context) {
    _utils.evalJS = EvalJS(
      context: context,
    );
  }

  void _loadProject(String projectName) {
    setState(() {
      _selectedProjectName = projectName;
    });
  }

  Future<bool> _isReadyToRun(BuildContext context) async {
    final storage = getIt<StorageManager>();
    final cacheProjectName = storage.getLocalBox("projectName");
    _apiClient.projectName = _selectedProjectName ?? cacheProjectName;
    ClientConfig? config;

    if (!kIsWeb) {
      await webview.loadLibrary();
      if (Platform.isIOS) {
        _bundle = await _apiClient.getAppWebviewBundle();
      }
    }

    await _initWebViewForMobile(context);

    try {
      config = await _apiClient.getClientConfig();
      // await _registerSocketIOClient(config);
    } catch (error) {
      await server_not_found.loadLibrary();
      setState(() {
        _cannotLoadConfig = error.toString();
      });
    }
    var contextStateProvider = getIt<ContextStateProvider>();

    contextStateProvider.appConfig = config;
    contextStateProvider.selectedProject = _selectedProjectName;

    await page_container.loadLibrary();

    if (kIsWeb) _loadWebCoreJSCode(context);
    return true;
  }

  Future<bool> _loadSelectProjectPage(BuildContext context) async {
    final storage = getIt<StorageManager>();
    final cacheProjectName = storage.getLocalBox("projectName");
    if (storage.getLocalBox("remember") == true && cacheProjectName != null) {
      _selectedProjectName = cacheProjectName;
      await _isReadyToRun(context);
      return true;
    }

    await select_project.loadLibrary();
    return true;
  }

  // Future<void> _registerSocketIOClient(ClientConfig config) async {
  //   final socketioHost = config.socketioHost;
  //   if (socketioHost != null) {
  //     await singleton_register.loadLibrary();

  //     final host = socketioHost["host"];
  //     if (host is! String) {
  //       throw Exception("SocketIO host must be a string");
  //     }

  //     final options =
  //         socketioHost["options"] ?? UtilsManager.emptyMapStringDynamic;

  //     singleton_register.SingletonRegister.registerSocketIOClient(
  //       host,
  //       opts: options,
  //     );
  //   }
  // }

  Future<void> _initWebViewForMobile(BuildContext context) async {
    Completer<bool> completer = Completer<bool>();

    if (_headlessWebView != null) return;

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
      onWebViewCreated: (webViewController) {
        print("1");
      },
      onLoadStart: (webViewController, url) async {
        print("2");
        try {
          _evalJS = EvalJS(
            context: context,
            webViewController: webViewController,
          );

          _utils.evalJS = _evalJS;
          completer.complete(true);
        } catch (error) {
          _headlessWebView?.dispose();
          _headlessWebView = null;
          _utils.evalJS = null;
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
        print("3");
      },
      onLoadError: (controller, url, code, message) {
        log("\x1B[31m$message\x1B[31m");
        completer.complete(false);
      },
      onConsoleMessage: (controller, consoleMessage) {
        log("Webview log: ${consoleMessage.message}");
      },
    );

    await completer.future;
  }


  bool _didLoadDeps = false;
  Future<bool> _prepareDependencies() async {
    if (_didLoadDeps) return true;



    _didLoadDeps = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    context.select((AuthContextProvider value) {
      return value;
    });

    if (_cannotLoadConfig != null) {
      return server_not_found.ServerNotFound();
    }

    return FutureBuilder<bool>(
      key: ValueKey(_selectedProjectName),
      future: _selectedProjectName == null
          ? _loadSelectProjectPage(context)
          : _isReadyToRun(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Offstage();
        }
        if (_selectedProjectName == null) {
          return select_project.SelectProjectPage(
            loadProject: _loadProject,
          );
        } else {
          return ScreenUtilInit(
            builder: (context, child) {
              return child!;
            },
            child: page_container.PageContainer(),
          );
        }
      },
    );
  }
}
