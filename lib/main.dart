import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/permission_manager.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/tool_components/page_container_widget.dart'
    deferred as page_container;
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 't_widget_interface/client_config/client_config.dart';
import 'dart:io' if (dart.library.html) "dart:html";
import 'package:url_strategy/url_strategy.dart';
import 'package:the_tool/static_pages/select_project.dart'
    deferred as select_project;
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

void main() async {
  // debugRepaintRainbowEnabled = true;

  if (!kIsWeb) {
    // if (Platform.isAndroid || Platform.isIOS) {
    await ScreenUtil.ensureScreenSize();
    // }
  }

  WidgetsFlutterBinding.ensureInitialized();
  SchemaValidator.enabled = false;
  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();

  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }
  getIt.registerSingleton<UtilsManager>(UtilsManager(), signalsReady: true);
  getIt.registerSingleton<StorageManager>(StorageManager(), signalsReady: true);
  await getIt<StorageManager>().initStorageBox();

  getIt.registerSingleton<APIClientManager>(
    APIClientManager(),
    signalsReady: true,
  );
  getIt.registerSingleton<ContextStateProvider>(
    ContextStateProvider(),
    signalsReady: true,
  );
  getIt.registerSingleton<PermissionManager>(
    PermissionManager(),
    signalsReady: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<ContextStateProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            getIt.registerSingleton<ThemeProvider>(
              ThemeProvider(context: context),
              signalsReady: true,
            );
            return getIt<ThemeProvider>();
          },
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedProjectName;

  Future<void> _loadWebCoreJSCode(BuildContext context) async {
    UtilsManager utils = getIt<UtilsManager>();
    EvalJS evalJS;

    evalJS = EvalJS(
      context: context,
    );

    utils.evalJS = evalJS;
  }

  void _loadProject(String projectName) {
    setState(() {
      _selectedProjectName = projectName;
    });
  }

  Future<bool> _isReadyToRun() async {
    final apiClient = getIt<APIClientManager>();
    final storage = getIt<StorageManager>();
    final cacheProjectName = storage.getLocalBox("projectName");
    apiClient.projectName = _selectedProjectName ?? cacheProjectName;
    ClientConfig config = await apiClient.getClientConfig();
    getIt<ContextStateProvider>().appConfig = config;
    await page_container.loadLibrary();

    if (kIsWeb) _loadWebCoreJSCode(context);

    return true;
  }

  Future<bool> _loadSelectProjectPage() async {
    final storage = getIt<StorageManager>();
    final cacheProjectName = storage.getLocalBox("projectName");
    if (storage.getLocalBox("remember") == true && cacheProjectName != null) {
      _selectedProjectName = cacheProjectName;
      await _isReadyToRun();
      return true;
    }

    await select_project.loadLibrary();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: ValueKey(_selectedProjectName),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Offstage();
        }
        if (_selectedProjectName == null) {
          return select_project.SelectProjectPage(
            loadProject: _loadProject,
          );
        } else {
          return page_container.PageContainer();
        }
      },
      future: _selectedProjectName == null
          ? _loadSelectProjectPage()
          : _isReadyToRun(),
    );
  }
}
