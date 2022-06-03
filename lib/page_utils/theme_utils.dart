import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

class ThemeManager {
  ThemeData? theme;
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

  ThemeManager();

  Future<ThemeData?> computeThemeData(Map<String, dynamic> themeMap) async {
    return ThemeData(
      primaryColor: ThemeDecoder.decodeColor("#ffa500"),
      scaffoldBackgroundColor: ThemeDecoder.decodeColor("#ff0000"),
      primarySwatch: MaterialColor(
        ThemeDecoder.decodeColor("#0000ff").hashCode,
        color,
      ),
      // colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: MaterialColor(
      //     ThemeDecoder.decodeColor("#ffa500").hashCode,
      //     color,
      //   ),
      // ),
    );
  }
}
