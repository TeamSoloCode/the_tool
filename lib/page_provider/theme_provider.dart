import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'package:the_tool/extensions/input_decoration_theme.extension.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.extension.dart';
import 'package:the_tool/t_widget_interface/media_screen_only/media_screen_only.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/page_utils/app_fonts/app_font.dart'
    deferred as app_font;

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  ThemeMode? _theme;
  Map<String, dynamic>? _classes;
  Map<String, dynamic>? _baseColor;
  late BuildContext context;
  var _themeRefreshToken = 0;
  static final UtilsManager utils = getIt<UtilsManager>();

  ThemeProvider();

  ThemeMode get currentThemeMode => _theme ?? ThemeMode.light;
  ThemeData? get themeData => _themeData;
  int? get themeRefreshToken => _themeRefreshToken;

  Map<String, dynamic>? get classes => _classes;
  Map<String, dynamic>? get baseColor => _baseColor;

  Map<String, dynamic>? _themeDataAsJSON;
  Map<String, dynamic>? get themeDataAsJSON => _themeDataAsJSON ?? const {};
  set themeDataAsJSON(Map<String, dynamic>? themeData) {
    _themeDataAsJSON = themeData;
  }

  void updateProviderContext(BuildContext newContext) {
    context = newContext;
  }

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

  void refreshThemeData() {
    _themeRefreshToken = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
  }

  Future<ThemeData?> computeThemeData(Map<String, dynamic> clientTheme) async {
    try {
      Map<String, dynamic> baseColor =
          _computeBaseColor(clientTheme["base"] ?? {});

      Map<String, dynamic> computedThemeMap = await _computeThemeMap(
        clientTheme["theme"],
        baseColor,
      );

      _classes = _mergeBaseColorToClasses(clientTheme, baseColor);

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
          validate: false,
        );

        // AppBarTheme? defaultAppBarTheme = themeData.appBarTheme;
        // AppBarTheme? appBarTheme = ThemeDecoder.decodeAppBarTheme(
        //   computedThemeMap["appBarTheme"],
        //   validate: false,
        // );

        InputDecorationTheme? defaultInputDecorationTheme =
            themeData.inputDecorationTheme;

        InputDecorationTheme? inputDecorationTheme =
            ThemeDecoder.decodeInputDecorationTheme(
          computedThemeMap["inputDecorationTheme"],
          validate: false,
        );

        _themeData = themeData.copyWith(
          primaryColor: ThemeDecoder.decodeColor(
            computedThemeMap["primaryColor"],
          ),
          scaffoldBackgroundColor: ThemeDecoder.decodeColor(
            computedThemeMap["scaffoldBackgroundColor"],
          ),
          appBarTheme: ThemeDecoder.decodeAppBarTheme(
            computedThemeMap["appBarTheme"],
          ),
          inputDecorationTheme: defaultInputDecorationTheme.merge(
            inputDecorationTheme,
          ),

          textButtonTheme: TextButtonThemeData(
            style: ThemeDecoder.decodeButtonStyle(
              computedThemeMap["textButtonTheme"],
            ),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ThemeDecoder.decodeButtonStyle(
              computedThemeMap["iconButtonTheme"],
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ThemeDecoder.decodeButtonStyle(
              computedThemeMap["elevatedButtonTheme"],
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: ThemeDecoder.decodeButtonStyle(
              computedThemeMap["filledButtonTheme"],
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ThemeDecoder.decodeButtonStyle(
              computedThemeMap["outlinedButtonTheme"],
            ),
          ),
          cardTheme: ThemeDecoder.decodeCardTheme(
            computedThemeMap["cardTheme"],
          ),

          // colorScheme: ColorScheme.fromSwatch(
          //   primarySwatch: MaterialColor(
          //     ThemeDecoder.decodeColor(
          //       computedThemeMap["primarySwatch"],
          //     ).hashCode,
          //     color,
          //   ),
          // ),
          textTheme: defaultTextTheme.merge(textTheme),
        );
      }

      return _themeData;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _computeBaseColor(
    Map<String, dynamic> baseColor,
  ) {
    try {
      if (baseColor.isEmpty) {
        return {};
      }

      Map<String, dynamic> darkBaseColor = baseColor["--dark"] ?? {};
      if (currentThemeMode == ThemeMode.dark && darkBaseColor.isNotEmpty) {
        baseColor.addAll(darkBaseColor);
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

  Future<Map<String, dynamic>> _computeTextThemeMap(
    Map<String, dynamic> textThemeMap,
  ) async {
    Map<String, dynamic> updatedTextTheme = textThemeMap;
    await app_font.loadLibrary();
    var appFont = app_font.AppFont();

    for (var entry in updatedTextTheme.entries) {
      var value = entry.value;
      if (value is String) {
        updatedTextTheme[entry.key] = await appFont.getFont(value);
      } else if (value is Map && UtilsManager.isTruthy(value["fontFamily"])) {
        var textStyleMap = value;
        var fontFamily = textStyleMap["fontFamily"];

        TextStyle fontStyle = await appFont.getFont(fontFamily);

        // Use fontFamily property from google font
        textStyleMap.remove("fontFamily");

        TextStyle? inlineStyle = ThemeDecoder.decodeTextStyle(textStyleMap);

        updatedTextTheme[entry.key] = fontStyle.merge(inlineStyle);
      }
    }

    return updatedTextTheme;
  }

  Future<Map<String, dynamic>> _computeThemeMap(
    Map<String, dynamic> themeMap,
    Map<String, dynamic> baseColor,
  ) async {
    var updatedThemeMap = _mergeBaseColorToTheme(
      themeMap,
      baseColor,
    );

    updatedThemeMap["textTheme"] = await _computeTextThemeMap(
      Map<String, dynamic>.from(
        updatedThemeMap["textTheme"],
      ),
    );

    return updatedThemeMap;
  }

  Map<String, dynamic> _mergeBaseColorToTheme(
    Map<String, dynamic> themeMap,
    Map<String, dynamic> baseColor,
  ) {
    try {
      if (themeMap.isEmpty) {
        return {};
      }

      String themeJSON = json.encode(themeMap);
      baseColor.forEach((key, value) {
        if (!key.startsWith("--")) {
          themeJSON = themeJSON.replaceAll(RegExp(key), value);
        }
      });

      /**
       * This because layout might have color value like 'red','blue','green', ...
       */
      themeMap = json.decode(themeJSON);
      (themeMap).forEach((key, value) {
        themeMap[key] = transformColorFromCSS(value);
      });

      return themeMap;
    } catch (e) {
      rethrow;
    }
  }

  T_MediaScreenOnlyProps margerClassesIntoMediaScreen(
    T_MediaScreenOnlyProps mediaScreen,
    Map<String, dynamic> contextData,
  ) {
    var className = mediaScreen.className;

    T_MediaScreenOnlyProps updatedMediaScreen = mediaScreen;

    if (className == null) {
      return mediaScreen;
    }

    updateWidgetProps(
      dynamic classData,
      String className,
    ) {
      if (classData != null) {
        var appliedClassProps = T_MediaScreenOnlyProps.fromJson(
          UtilsManager.deepConvertToStringKeyMap(classData),
        );

        updatedMediaScreen = updatedMediaScreen.merge(appliedClassProps);
      } else {
        log("Warning: Class $className is not exist !");
      }
    }

    if (className is String) {
      updateWidgetProps(classes?[className], className);
    } else if (className is List) {
      for (var cls in className) {
        if (cls is String) {
          updateWidgetProps(classes?[cls], cls);
        } else if (cls is Map) {
          cls.forEach((classname, value) {
            var result = value;

            if (UtilsManager.isValueBinding(value)) {
              result = utils.bindingValueToProp(
                contextData,
                value,
              );
            }

            if (UtilsManager.isTruthy(result)) {
              updateWidgetProps(classes?[classname], classname);
            }
          });
        }
      }
    }

    return updatedMediaScreen;
  }

  LayoutProps? mergeClasses(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    var className = widgetProps?.className;
    LayoutProps? updatedWidgetProps = widgetProps;

    if (className == null) {
      return widgetProps;
    }

    updateWidgetProps(
      dynamic classData,
      String className,
    ) {
      if (classData != null) {
        var appliedClassProps = LayoutProps.fromJson(
          UtilsManager.deepConvertToStringKeyMap(classData),
        );

        updatedWidgetProps = updatedWidgetProps?.merge(appliedClassProps);
      } else {
        log("Warning: Class $className is not exist !");
      }
    }

    if (className is String) {
      updateWidgetProps(classes?[className], className);
    } else if (className is List) {
      for (var cls in className) {
        if (cls is String) {
          updateWidgetProps(classes?[cls], cls);
        } else if (cls is Map) {
          cls.forEach((classname, value) {
            var result = value;

            if (UtilsManager.isValueBinding(value)) {
              result = utils.bindingValueToProp(
                contextData,
                value,
              );
            }

            if (UtilsManager.isTruthy(result)) {
              updateWidgetProps(classes?[classname], classname);
            }
          });
        }
      }
    }

    return updatedWidgetProps;
  }

  String? getBaseColorByKey(String key) {
    return baseColor == null ? null : baseColor![key];
  }

  dynamic transformColorFromCSS(dynamic inputValue) {
    if (inputValue is Map) {
      return inputValue
          .map((key, value) => MapEntry(key, transformColorFromCSS(value)));
    } else if (inputValue is List) {
      return inputValue.map((value) => transformColorFromCSS(value)).toList();
    } else if (inputValue is String) {
      inputValue = inputValue.trim();
      if (isCssColor(inputValue)) {
        if (colorKeywords.containsKey(inputValue)) {
          return Color(colorKeywords[inputValue]!);
        }

        return fromCssColor(inputValue);
      }
    }
    return inputValue;
  }

  Map<String, dynamic> mergeBaseColorIntoMap(Map<String, dynamic> map) {
    if (baseColor == null) {
      return map;
    }

    Map<String, dynamic> updatedMap = Map<String, dynamic>.from(map);

    map.forEach((key, value) {
      if (value is String && !key.toLowerCase().contains("color")) return;
      if (value is Map<String, dynamic>) {
        updatedMap[key] = mergeBaseColorIntoMap(value);
      } else if (value is String) {
        if (baseColor!.containsKey(value)) {
          updatedMap[key] = baseColor![value];
        }
      }
    });

    return updatedMap;
  }
}
