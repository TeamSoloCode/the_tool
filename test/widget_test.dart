// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_theme/json_theme_schemas.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_provider/resize_provider.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:the_tool/app.dart';
import 'package:the_tool/singleton_register.dart';
import 'package:the_tool/main.dart';
import 'package:the_tool/utils.dart';

void main() async {
  group("First test", () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      // var dir = await getApplicationDocumentsDirectory();

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

      await SingletonRegister.register();
      print("SingletonRegister");
    });

    testWidgets('Loading TheTool', (WidgetTester tester) async {
      await tester.pumpWidget(
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
      expect(1, 1);
    });
  });
}
