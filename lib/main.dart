import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/permission_manager.dart';
import 'package:the_tool/page_utils/storage_utils.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/tool_components/page_container_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 't_widget_interface/client_config/client_config.dart';

import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }
  getIt.registerSingleton<UtilsManager>(UtilsManager(), signalsReady: true);
  getIt.registerSingleton<StorageManager>(StorageManager(), signalsReady: true);
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

  ClientConfig config = await getIt<APIClientManager>().getClientConfig();
  getIt<ContextStateProvider>().appConfig = config;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => getIt<ContextStateProvider>()),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(context: context),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (kIsWeb) _loadWebCoreJSCode(context);
    super.initState();
  }

  Future<void> _loadWebCoreJSCode(BuildContext context) async {
    UtilsManager utils = getIt<UtilsManager>();
    EvalJS evalJS;
    APIClientManager apiClient = getIt<APIClientManager>();

    evalJS = EvalJS(
      contextStateProvider: context.read<ContextStateProvider>(),
      context: context,
    );
    String clientCore = await apiClient.getClientCore();

    await evalJS.setupReactForClientCode(
      clientCore,
    );

    utils.evalJS = evalJS;
  }

  @override
  Widget build(BuildContext context) {
    return const PageContainer();
  }
}
