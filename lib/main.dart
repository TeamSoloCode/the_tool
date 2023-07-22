import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:the_tool/app.dart' deferred as app;
import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_provider/resize_provider.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/singleton_register.dart'
    deferred as singleton_register;
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

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

  await Future.wait([
    singleton_register.loadLibrary(),
    app.loadLibrary(),
  ]);

  await singleton_register.SingletonRegister.register();

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
      child: app.TheTool(),
    ),
  );
}
