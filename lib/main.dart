import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_base_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  getIt.registerSingleton<UtilsManager>(UtilsManager(), signalsReady: true);
  getIt.registerSingleton<APIClientManager>(
    APIClientManager(),
    signalsReady: true,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ContextStateProvider()),
    ],
    child: MyApp(),
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
    return T_BaseWidget();
  }
}
