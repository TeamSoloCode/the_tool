@JS()
library web_js_invoke;

import 'dart:convert';
import 'dart:developer';
import 'dart:js' as js;
import 'dart:js_util' as js_util;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/utils.dart';

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
  )
      f,
);

@JS('toggle_change_theme')
external set toogleChangeTheme(
  void Function(
    String args,
  )
      f,
);

@JS('fetch_data')
external set fetchData(
  void Function(String id, String path, String optionJSON) f,
);

@JS('dispatch_form_action')
external set dispathFormAction(
  void Function(String eventName, String eventData) f,
);

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
  Navigator.of(_context).pushNamed("/$routeName", arguments: arguments);
}

void _toogleChangeTheme(String args) {
  _context.read<ThemeProvider>().toogleChangeThemeMode(null);
}

void _fetchData(String id, String path, String optionJSON) {
  _emitDataResponseEvent(id, path, json.decode(optionJSON));
}

void _dispatchFormAction(String eventName, String eventData) {
  getIt<UtilsManager>().emitter.emit(eventName, _context, eventData);
}

void _emitDataResponseEvent(
  String id,
  String path,
  Map<String, dynamic> options,
) async {
  RequestOptions requestOptions = RequestOptions(
    path: path,
    method: options["method"],
    data: options["body"],
  );
  var res = await getIt<APIClientManager>().fetchData(
    requestOptions: requestOptions,
  );
  js.context.callMethod("__ondataresponse", [
    id,
    json.encode({"err": res["err"], "message": res["message"], "response": res})
  ]);
}

void main() {
  setContextData = allowInterop(_setState);
  navigator = allowInterop(_navigator);
  toogleChangeTheme = allowInterop(_toogleChangeTheme);
  fetchData = allowInterop(_fetchData);
  dispathFormAction = allowInterop(_dispatchFormAction);
}
