import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:json_theme/json_theme_schemas.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  ThemeMode? _theme;
  BuildContext context;

  Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };

  ThemeProvider({required this.context});

  ThemeMode get currentThemeMode => _theme ?? ThemeMode.light;
  void toogleChangeThemeMode(ThemeMode? mode) {
    if (mode == null) {
      _theme = currentThemeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      _theme = mode;
    }
    notifyListeners();
  }

  Future<ThemeData?> computeThemeData(Map<String, dynamic> themeMap) async {
    try {
      Map<String, dynamic> computedThemeMap = _mergeBaseColorToTheme(themeMap);
      log("baseColor $computedThemeMap");
      if (computedThemeMap.isEmpty) {
        if (currentThemeMode == ThemeMode.dark) {
          return ThemeData.dark();
        }
        return ThemeData.light();
      }
      var themeData = currentThemeMode == ThemeMode.light
          ? ThemeData.light()
          : ThemeData.dark();

      return themeData.copyWith(
        primaryColor: fromCssColor(computedThemeMap["primaryColor"]),
        scaffoldBackgroundColor: fromCssColor(
          computedThemeMap["scaffoldBackgroundColor"],
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            fromCssColor(computedThemeMap["primarySwatch"]).hashCode,
            color,
          ),
        ),
        textTheme: themeData.textTheme.copyWith(
          bodyText1: themeData.textTheme.bodyText1!.copyWith(
            color: Colors.green,
          ),
          bodyText2: themeData.textTheme.bodyText2!.copyWith(
            color: Colors.green,
          ),
          overline: themeData.textTheme.overline!.copyWith(
            color: Colors.red,
          ),
          caption: themeData.textTheme.caption!.copyWith(
            color: Colors.red,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _mergeBaseColorToTheme(
    Map<String, dynamic> themeMap,
  ) {
    try {
      Map<String, dynamic> theme = themeMap["theme"] ?? {};
      if (theme.isEmpty) {
        return {};
      }

      Map<String, dynamic> baseColor = themeMap["base"] ?? {};
      if (baseColor.isEmpty) {
        return themeMap;
      }

      Map<String, dynamic> darkBaseColor = baseColor["--dark"] ?? {};
      if (currentThemeMode == ThemeMode.dark && darkBaseColor.isNotEmpty) {
        baseColor = {...baseColor, ...darkBaseColor};
      }

      String themeJSON = json.encode(theme);
      baseColor.forEach((key, value) {
        if (!key.startsWith("--")) {
          themeJSON = themeJSON.replaceAll(RegExp(key), value);
        }
      });

      return json.decode(themeJSON);
    } catch (e) {
      rethrow;
    }
  }
}
