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
  ThemeData? get themeData => _themeData;
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

      if (computedThemeMap.isEmpty) {
        currentThemeMode == ThemeMode.dark
            ? _themeData = ThemeData.dark()
            : _themeData = ThemeData.light();
      } else {
        var themeData = currentThemeMode == ThemeMode.light
            ? ThemeData.light()
            : ThemeData.dark();

        TextTheme? textTheme = ThemeDecoder.decodeTextTheme(
          computedThemeMap["textTheme"],
        );
        TextTheme? defaultTextTheme = themeData.textTheme;

        _themeData = themeData.copyWith(
          primaryColor:
              ThemeDecoder.decodeColor(computedThemeMap["primaryColor"]),
          scaffoldBackgroundColor: ThemeDecoder.decodeColor(
            computedThemeMap["scaffoldBackgroundColor"],
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(
              ThemeDecoder.decodeColor(
                computedThemeMap["primarySwatch"],
              ).hashCode,
              color,
            ),
          ),
          textTheme: defaultTextTheme.merge(textTheme),
        );
      }

      return _themeData;
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

      theme = json.decode(themeJSON);
      Map<String, dynamic> updateTheme = {};
      (theme).forEach((key, value) {
        updateTheme[key] = transformColorFromCSS(value);
      });
      log("updateTheme $updateTheme");
      return updateTheme;
    } catch (e) {
      rethrow;
    }
  }

  dynamic transformColorFromCSS(dynamic mapOrValue) {
    if (mapOrValue is Map) {
      var updateValue = {};
      mapOrValue.forEach((key, value) {
        updateValue[key] = transformColorFromCSS(value);
      });
      return updateValue;
    } else {
      if (isCssColor(mapOrValue)) {
        return fromCssColor(mapOrValue).toCssString();
      }
      return mapOrValue;
    }
  }
}
