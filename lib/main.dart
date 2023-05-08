import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/js_utils/base_invoke_is.dart';
import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/permission_manager.dart';
import 'package:the_tool/page_provider/resize_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/tool_components/page_container_widget.dart'
    deferred as page_container;
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 't_widget_interface/client_config/client_config.dart';
import 'dart:io' if (dart.library.html) "dart:html";
import 'package:url_strategy/url_strategy.dart';
import 'package:the_tool/static_pages/select_project.dart'
    deferred as select_project;
import 'package:the_tool/js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/js_utils/web_eval_utils/web_eval_js.dart';
import 'package:the_tool/config/config.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props_reflectable.dart'
    as layout_props_reflectable;

void main() async {
  // debugRepaintRainbowEnabled = true;
  layout_props_reflectable.main();
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
  getIt.registerSingleton<EnvironmentConfig>(
    EnvironmentConfig(),
    signalsReady: true,
  );
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
  getIt.registerSingleton<ResizeProvider>(
    ResizeProvider(),
    signalsReady: true,
  );
  getIt.registerSingleton<PermissionManager>(
    PermissionManager(),
    signalsReady: true,
  );
  getIt.registerSingleton<ThemeProvider>(
    ThemeProvider(),
    signalsReady: true,
  );

  getIt.registerSingleton<AuthContextProvider>(
    AuthContextProvider(),
    signalsReady: true,
  );

  getIt.registerSingleton<BaseInvokeJS>(
    const BaseInvokeJS(),
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
            var themeProvider = getIt<ThemeProvider>();
            themeProvider.updateProviderContext(context);
            return themeProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<ResizeProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<AuthContextProvider>(),
        ),
      ],
      child: const TheTool(),
    ),
  );
}

class TheTool extends StatefulWidget {
  const TheTool({Key? key}) : super(key: key);

  @override
  State<TheTool> createState() => _TheToolState();
}

class _TheToolState extends State<TheTool> {
  String? _selectedProjectName;

  void _loadWebCoreJSCode(BuildContext context) {
    UtilsManager utils = getIt<UtilsManager>();

    utils.evalJS = EvalJS(
      context: context,
    );
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
    context.select((AuthContextProvider value) {
      return value;
    });

    return FutureBuilder<bool>(
      key: ValueKey(_selectedProjectName),
      future: _selectedProjectName == null
          ? _loadSelectProjectPage()
          : _isReadyToRun(),
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
