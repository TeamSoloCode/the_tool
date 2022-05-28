@JS()
library web_js_invoke;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';

late ContextStateProvider _contextStateProvider;
late BuildContext _context;
void setContextStateProvider(ContextStateProvider contextStateProvider) {
  _contextStateProvider = contextStateProvider;
}

void setContextBuilder(BuildContext context) {
  _context = context;
}

@JS('setState')
external set setContextData(
    void Function(String dataAsString, Function? callback) f);

@JS('navigate')
external set navigator(
  void Function(
    String routeName,
    String pageArguments,
  ),
);

/// Allows calling the assigned function from Dart as well.
@JS()
external void setState();

/// It takes a JSON string, decodes it into a Map, and then merges it with the existing context data
///
/// Args:
///   dataAsString (String): The data to be set as a string.
///   callback (Function?): This is the function that will be called when the state is set.
void _setState(String dataAsString, Function? callback) {
  Map<String, dynamic> data = json.decode(dataAsString);

  _contextStateProvider.updateContextData(
    {
      ..._contextStateProvider.contextData,
      ...data,
    },
  );
}

void _navigator(String routeName, String pageArguments) {
  Map<String, dynamic> arguments = json.decode(pageArguments);
  Navigator.of(_context).pushNamed(routeName, arguments: arguments);
}

void main() {
  setContextData = allowInterop(_setState);
  navigator = allowInterop(_navigator);
}
