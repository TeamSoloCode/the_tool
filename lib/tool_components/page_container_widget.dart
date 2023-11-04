import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderLocalizations;
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/route/app_module.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  ThemeData? _themeData;
  ThemeMode? _currentThemeMode;

  @override
  Widget build(BuildContext context) {
    context.select(
      (ThemeProvider theme) {
        if (_currentThemeMode != theme.currentThemeMode) {
          _updateTheme();
        }
        _currentThemeMode = theme.currentThemeMode;
        return theme.currentThemeMode;
      },
    );

    var config = getIt<ContextStateProvider>().appConfig;

    return ModularApp(
      module: AppModule(config!),
      child: MaterialApp.router(
        scaffoldMessengerKey: _scaffoldKey,
        theme: _themeData,
        themeMode: _currentThemeMode,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('en'),
        ],
        localizationsDelegates: const [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        builder: (context, child) {
          getIt<ContextStateProvider>()
              .registerKeyScaffoldMessengerState(_scaffoldKey);
          ScreenUtil.init(context);
          return child!;
        },
      ),
    );
  }

  Future<void> _updateTheme() async {
    var theme = await getIt<UtilsManager>().evalJS!.getClientTheme();
    var themeProvider = getIt<ThemeProvider>();
    var currentThemeData = await themeProvider.computeThemeData(theme);

    setState(() {
      _themeData = currentThemeData;
      themeProvider.refreshThemeData();
    });
  }
}
