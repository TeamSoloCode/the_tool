import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_utils.dart';
import 'package:the_tool/tool_components/t_base_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }

  getIt.registerSingleton<UtilsManager>(UtilsManager(), signalsReady: true);
  getIt.registerSingleton<StorageManager>(StorageManager(), signalsReady: true);
  getIt.registerSingleton<APIClientManager>(
    const APIClientManager(),
    signalsReady: true,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ContextStateProvider()),
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const T_BaseWidget();
  }
}
