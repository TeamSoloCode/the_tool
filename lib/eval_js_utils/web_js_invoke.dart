@JS()
library web_js_invoke;

import 'dart:convert';
import 'dart:js';

import 'package:js/js.dart';
import 'package:provider/provider.dart' as provider;
import 'package:the_tool/page_utils/context_state_provider.dart';

late ContextStateProvider _contextStateProvider;

void setContextStateProvider(ContextStateProvider contextStateProvider) {
  _contextStateProvider = contextStateProvider;
}

@JS('setState')
external set setContextData(
    void Function(String dataAsString, Function? callback) f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void setState();

void _setState(String dataAsString, Function? callback) {
  Map<String, dynamic> data = json.decode(dataAsString);

  _contextStateProvider.updateContextData(
    {
      ..._contextStateProvider.contextData,
      ...data,
    },
  );
}

void main() {
  setContextData = allowInterop(_setState);
}
