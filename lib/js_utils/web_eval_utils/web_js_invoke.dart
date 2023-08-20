// ignore_for_file: avoid_web_libraries_in_flutter

@JS()
library web_js_invoke;

import 'dart:convert';
import 'dart:js' as js;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:the_tool/api/client_api.dart';
import 'package:the_tool/js_utils/base_eval_js.dart';
import 'package:the_tool/js_utils/base_invoke_is.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
import 'package:the_tool/utils.dart';

late ContextStateProvider _contextStateProvider;
late BuildContext _context;
late BaseEvalJS _evalJS;
void setContextStateProvider(ContextStateProvider contextStateProvider) {
  _contextStateProvider = contextStateProvider;
}

void setContextBuilder(BuildContext context) {
  _context = context;
}

void setEvalJS(BaseEvalJS evalJS) {
  _evalJS = evalJS;
}

@JS('setState')
external set setContextData(
    void Function(String dataAsString, Function? callback) f);

@JS('navigate')
external set navigator(
  void Function(
    String routeName,
    String pageArguments,
    String optionsAsJSON,
  ) f,
);

@JS('toggle_change_theme')
external set toogleChangeTheme(
  void Function(
    String args,
  ) f,
);

@JS('fetch_data')
external set fetchData(
  void Function(String id, String path, String optionJSON) f,
);

@JS('dispatch_form_action')
external set dispathFormAction(
  void Function(String eventName, String eventData) f,
);

@JS("open_drawer")
external set openDrawer(void Function(String pageId) f);

@JS("update_route_auth_data")
external set updateRouteAuthData(
  String Function(
    String action,
    String routeAuthAsJSON,
  ) f,
);

@JS('__tWeb_callAsyncJavaScript')
external callAsyncJavaScript(String code);

@JS('js_response')
external set jsResponse(void Function(String eventName, String payload) f);

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

void _navigator(String routeName, String pageArguments, String optionsAsJSON) {
  Map<String, dynamic> data = json.decode(pageArguments);
  Map<String, dynamic>? options = json.decode(optionsAsJSON);

  final route = "/$routeName";

  getIt<BaseInvokeJS>().processNavigate(route, data, options);
}

void _toogleChangeTheme(String args) {
  getIt<ThemeProvider>().toogleChangeThemeMode(null);
}

void _fetchData(String id, String path, String optionJSON) {
  _emitDataResponseEvent(id, path, json.decode(optionJSON));
}

void _dispatchFormAction(String eventName, String eventData) {
  getIt<UtilsManager>().emitter.emit(eventName, _context, eventData);
}

void _openPageDrawer(String pageId) {
  var pageStateKey = getIt<ContextStateProvider>().mapKeyScaffoldState[pageId];
  if (pageStateKey != null) {
    pageStateKey.currentState?.openDrawer();
  }
}

String _updateRouteAuthData(String action, String routeAuthAsJSON) {
  return getIt<BaseInvokeJS>().updateRouteAuthData(action, routeAuthAsJSON);
}

void emitFormActionResponse(String id, dynamic data) {
  _evalJS.callJS(
    "__ondataresponse",
    "",
    [
      id,
      json.encode({"result": data}),
    ],
  );
}

void _jsResponse(String eventName, String payload) {
  var emitter = getIt<UtilsManager>().emitter;

  emitter.emit(eventName, _context, payload);
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

  _evalJS.callJS(
    "__ondataresponse",
    "",
    [
      id,
      json.encode({
        "err": res["err"],
        "message": res["message"],
        "response": res,
      }),
    ],
  );
}

void main() {
  setContextData = allowInterop(_setState);
  navigator = allowInterop(_navigator);
  toogleChangeTheme = allowInterop(_toogleChangeTheme);
  fetchData = allowInterop(_fetchData);
  dispathFormAction = allowInterop(_dispatchFormAction);
  openDrawer = allowInterop(_openPageDrawer);
  updateRouteAuthData = allowInterop(_updateRouteAuthData);
  jsResponse = allowInterop(_jsResponse);
}
