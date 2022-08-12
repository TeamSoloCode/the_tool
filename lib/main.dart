import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/permission_manager.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/page_utils/twidget_context_provider.dart';
import 'package:the_tool/static_pages/select_project.dart';
import 'package:the_tool/tool_components/page_container_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 't_widget_interface/client_config/client_config.dart';
import 'package:json_theme/json_theme_schemas.dart';

import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SchemaValidator.enabled = false;

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

  getIt.registerSingleton<PageContextProvider>(
    PageContextProvider(),
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
    APIClientManager apiClient = getIt<APIClientManager>();

    evalJS = EvalJS(
      context: context,
    );
    String clientCore = await apiClient.getClientCore();

    await evalJS.setupReactForClientCode(
      clientCore,
    );

    utils.evalJS = evalJS;
  }

  void _loadProject(String projectName) {
    setState(() {
      _selectedProjectName = projectName;
    });
  }

  Future<bool> _isReadyToRun() async {
    return Future<bool>.microtask(() async {
      var apiClient = getIt<APIClientManager>();

      apiClient.projectName = _selectedProjectName ??
          getIt<StorageManager>().getLocalBox("projectName");
      ClientConfig config = await apiClient.getClientConfig();
      getIt<ContextStateProvider>().appConfig = config;

      if (kIsWeb) _loadWebCoreJSCode(context);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedProjectName == null) {
      return SelectProjectPage(
        loadProject: _loadProject,
      );
    } else {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.data != true) {
            return SizedBox();
          }
          return const PageContainer();
        },
        future: _isReadyToRun(),
      );
    }
  }
}
