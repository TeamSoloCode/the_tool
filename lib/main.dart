import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/permission_manager.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/tool_components/page_container_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 't_widget_interface/client_config/client_config.dart';
import 'dart:io' if (dart.library.html) "dart:html";
import 'package:the_tool/static_pages/select_project.dart'
    deferred as select_project;
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

void main() async {
  if (!kIsWeb) {
    // if (Platform.isAndroid || Platform.isIOS) {
    await ScreenUtil.ensureScreenSize();
    // }
  }

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

  Future<bool> _loadSelectProjectPage() async {
    return Future<bool>.microtask(() async {
      await select_project.loadLibrary();
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: ValueKey(_selectedProjectName),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        if (_selectedProjectName == null) {
          return select_project.SelectProjectPage(
            loadProject: _loadProject,
          );
        } else {
          return const PageContainer();
        }
      },
      future: _selectedProjectName == null
          ? _loadSelectProjectPage()
          : _isReadyToRun(),
    );
  }
}
