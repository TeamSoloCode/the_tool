import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:json_theme/json_theme_schemas.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  ThemeMode? _theme;
  Map<String, dynamic>? _classes;
  Map<String, dynamic>? _baseColor;
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
  Map<String, dynamic>? get classes => _classes;
  Map<String, dynamic>? get baseColor => _baseColor;

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
      Map<String, dynamic> baseColor = _computeBaseColor(themeMap);
      Map<String, dynamic> computedThemeMap = _mergeBaseColorToTheme(
        themeMap,
        baseColor,
      );
      _classes = _mergeBaseColorToClasses(themeMap, baseColor);

      if (computedThemeMap.isEmpty) {
        currentThemeMode == ThemeMode.dark
            ? _themeData = ThemeData.dark()
            : _themeData = ThemeData.light();
      } else {
        var themeData = currentThemeMode == ThemeMode.light
            ? ThemeData.light()
            : ThemeData.dark();

        TextTheme? defaultTextTheme = themeData.textTheme;
        TextTheme? textTheme = ThemeDecoder.decodeTextTheme(
          computedThemeMap["textTheme"],
        );

        _themeData = themeData.copyWith(
          primaryColor: ThemeDecoder.decodeColor(
            computedThemeMap["primaryColor"],
          ),
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

  Map<String, dynamic> _computeBaseColor(
    Map<String, dynamic> themeMap,
  ) {
    try {
      Map<String, dynamic> baseColor = themeMap["base"] ?? {};
      if (baseColor.isEmpty) {
        return {};
      }

      Map<String, dynamic> darkBaseColor = baseColor["--dark"] ?? {};
      if (currentThemeMode == ThemeMode.dark && darkBaseColor.isNotEmpty) {
        baseColor = {...baseColor, ...darkBaseColor};
      }
      _baseColor = baseColor;
      return baseColor;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _mergeBaseColorToClasses(
    Map<String, dynamic> themeMap,
    Map<String, dynamic> baseColor,
  ) {
    try {
      Map<String, dynamic> classes = themeMap["classes"] ?? {};
      if (classes.isEmpty) {
        return {};
      }

      String classesJSON = json.encode(classes);
      baseColor.forEach((key, value) {
        if (!key.startsWith("--")) {
          classesJSON = classesJSON.replaceAll(RegExp(key), value);
        }
      });

      /**
       * This because layout might have color value like 'red','blue','green', ...
       */
      classes = json.decode(classesJSON);
      (classes).forEach((key, value) {
        classes[key] = transformColorFromCSS(value);
      });

      return classes;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _mergeBaseColorToTheme(
    Map<String, dynamic> themeMap,
    Map<String, dynamic> baseColor,
  ) {
    try {
      Map<String, dynamic> theme = themeMap["theme"] ?? {};
      if (theme.isEmpty) {
        return {};
      }

      String themeJSON = json.encode(theme);
      baseColor.forEach((key, value) {
        if (!key.startsWith("--")) {
          themeJSON = themeJSON.replaceAll(RegExp(key), value);
        }
      });

      /**
       * This because layout might have color value like 'red','blue','green', ...
       */
      theme = json.decode(themeJSON);
      (theme).forEach((key, value) {
        theme[key] = transformColorFromCSS(value);
      });

      log("abcd $theme");
      return theme;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> mergeBaseColor(dynamic content) {
    try {
      var rawContent = json.encode(content);

      baseColor?.forEach((key, value) {
        if (!key.startsWith("--")) {
          rawContent = rawContent.replaceAll(RegExp(key), value);
        }
      });

      return json.decode(rawContent);
    } catch (e) {
      rethrow;
    }
  }

  static dynamic transformColorFromCSS(dynamic inputValue) {
    try {
      if (inputValue is Map) {
        var updateValue = {};
        inputValue.forEach((key, value) {
          updateValue[key] = transformColorFromCSS(value);
        });
        return updateValue;
      } else if (inputValue is List) {
        var updateValue = [];
        inputValue.forEach((value) {
          updateValue.add(transformColorFromCSS(value));
        });
        return updateValue;
      } else {
        if (isCssColor(inputValue)) {
          return fromCssColor(inputValue).toCssString();
        }
        return inputValue;
      }
    } catch (e) {
      rethrow;
    }
  }
}
