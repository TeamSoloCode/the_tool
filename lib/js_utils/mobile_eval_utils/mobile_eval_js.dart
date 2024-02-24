import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/js_utils/base_eval_js.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/js_utils/mobile_eval_utils/mobile_js_invoke.dart'
    as mobile_js_invoke;
import 'package:eventify/eventify.dart' as eventify;

class EvalJS extends BaseEvalJS {
  dynamic webViewController;
  late ContextStateProvider contextState;
  late eventify.EventEmitter emitter;

  EvalJS({
    this.webViewController,
    required context,
  }) : super(
          context: context,
        ) {
    contextState = getIt<ContextStateProvider>();
    mobile_js_invoke.main();
    mobile_js_invoke.registerJavascriptHandler(
      context,
      contextState,
      webViewController,
    );

    emitter = getIt<UtilsManager>().emitter;
  }

  static const List<String> _stringPhareSymbols = ["'", "\"", "`", "`"];

  @override
  Future<dynamic> callJS(
    String functionName,
    String pageId,
    List<dynamic> args,
  ) async {
    // log("callJS function $functionName, args $args");
    var eventName = UniqueKey().toString();
    var funcCharList = functionName.trim().split("");
    var preparedFunctionName = functionName;

    if (funcCharList.any(
      (element) => _stringPhareSymbols.contains(element),
    )) {
      preparedFunctionName = funcCharList.map((char) {
        if (_stringPhareSymbols.contains(char)) {
          return "\\$char";
        }
        return char;
      }).join();
    }

    webViewController?.callAsyncJavaScript(
      functionBody:
          "appBridge.emitJSFunction('$eventName', '$preparedFunctionName', '$pageId', ${jsonEncode(args)})",
    );

    Completer<dynamic> completer = Completer<dynamic>();

    void responseFromJS(event, context) {
      completer.complete(event.eventData);
    }

    var listener = emitter.on(eventName, context, responseFromJS);

    try {
      var result = await completer.future;
      var resultObject = jsonDecode(result);

      if (resultObject["error"] != null) {
        throw Exception(resultObject["error"]);
      }

      return resultObject["data"];
    } finally {
      listener.cancel();
      emitter.off(listener);
    }
  }

  @override
  Future<void> executePageCode({
    required String clientCode,
    required String pagePath,
  }) async {
    String pageCode = """
      (() => {
        ${getBaseComponentCode(
      pagePath: pagePath,
      clientCode: clientCode,
    )}
      })()
      """;

    webViewController?.evaluateJavascript(source: pageCode);
  }

  @override
  void addClientPage(String pagePath) {
    callJS("addClientPage", "", [
      {"pagePath": pagePath}
    ]);
  }

  @override
  void removeClientPage(String pagePath) {
    callJS("removeClientPage", "", [
      {"pagePath": pagePath}
    ]);
  }

  @override
  Future<Map<String, dynamic>?> getClientPageLayout(String pagePath) async {
    final projectName = getIt<StorageManager>().getProjectName();
    var result = await callJS("getClientPagelayout", "", [
      projectName,
      {"pagePath": pagePath}
    ]);

    return result;
  }

  @override
  Future<ClientConfig> getClientConfig() async {
    final projectName = getIt<StorageManager>().getProjectName();
    final rawJSONConfig = await callJS("getClientConfig", "", [projectName]);
    return ClientConfig.fromJson(rawJSONConfig);
  }

  @override
  Future<Map<String, dynamic>> getClientTheme() async {
    final projectName = getIt<StorageManager>().getProjectName();
    return await callJS("getClientTheme", "", [projectName]);
  }

  @override
  void unmountClientCode(String pagePath) {
    removeClientPage(pagePath);
  }

  @override
  void setPageArguments(Map<String, dynamic> args, String pagePath) {
    // webViewController?.runJavascript("context['$pagePath']._ = args;");
  }

  @override
  void emitFormActionResponse(String id, data) {
    callJS(
      "__ondataresponse",
      "",
      [
        id,
        json.encode({"result": data})
      ],
    );
  }

  @override
  Future<LayoutProps> registerSubComponent({
    required String parentPagePath,
    required String componentPath,
    Map<dynamic, dynamic> componentPropsAsJSON = const {},
    Map<dynamic, dynamic> computedComponentPropsAsJSON = const {},
  }) async {
    var pageLayout = await callJS(
      "__registerSubComponent__",
      parentPagePath,
      [componentPath, componentPropsAsJSON],
    );

    return LayoutProps.fromJson(pageLayout);
  }
}
