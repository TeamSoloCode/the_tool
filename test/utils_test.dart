// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_tool/config/prod.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/singleton_register.dart';
import 'package:the_tool/utils.dart';

void main() {
  getIt.registerSingleton<EnvironmentConfig>(
    EnvironmentConfig(),
    signalsReady: true,
  );

  getIt.registerSingleton<UtilsManager>(UtilsManager(), signalsReady: true);

  getIt.registerSingleton<ContextStateProvider>(
    ContextStateProvider(),
    signalsReady: true,
  );

  getIt.registerSingleton<ThemeProvider>(
    ThemeProvider(),
    signalsReady: true,
  );

  var utils = UtilsManager();
  test(
      'hasBindingValue returns true if widgetPropsAsJSON contains a binding value',
      () {
    final widgetPropsAsJSON = {
      'type': 'text',
      'text': '{{ username }}',
      'subText': '{{ password }}',
      'style': "textTheme.bodyText1",
      "leading": {
        "type": "icon",
        "text": "{{ should be ignored }}",
      },
      "child": {
        "type": "text",
        "text": "{{ should be ignored }}",
      }
    };

    var hasBinding = false;
    var bindingStrings = <String>[];
    var hasThemeBinding = false;

    hasBinding = utils.hasBindingValue(
      widgetPropsAsJSON,
      (bindingString) {
        bindingStrings.add(bindingString);
      },
      hasThemeBindingValue: () {
        hasThemeBinding = true;
      },
    );

    expect(hasBinding, isTrue);
    expect(
      bindingStrings,
      ['username', 'password'],
    );
    expect(hasThemeBinding, isTrue);
  });

  test(
      'hasBindingValue returns false if widgetPropsAsJSON does not contain a binding value',
      () {
    final widgetPropsAsJSON = {
      'type': 'text',
      'text': 'username',
      'style': {
        'color': 'red',
      },
    };

    var hasBinding = false;
    var bindingStrings = <String>[];
    var hasThemeBinding = false;

    hasBinding = utils.hasBindingValue(
      widgetPropsAsJSON,
      (bindingString) {
        bindingStrings.add(bindingString);
      },
      hasThemeBindingValue: () {
        hasThemeBinding = true;
      },
    );

    expect(hasBinding, isFalse);
    expect(bindingStrings, isEmpty);
    expect(hasThemeBinding, isFalse);
  });
}
