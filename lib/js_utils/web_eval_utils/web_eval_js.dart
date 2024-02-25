import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:the_tool/js_utils/base_eval_js.dart';
import 'package:the_tool/js_utils/web_eval_utils/web_js_invoke.dart'
    as web_js_invoke;
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';
import 'package:eventify/eventify.dart' as eventify;

class EvalJS extends BaseEvalJS {
  var webViewController;
  late ContextStateProvider contextState;
  late eventify.EventEmitter emitter;

  EvalJS({
    this.webViewController,
    required context,
  }) : super(context: context) {
    contextState = getIt<ContextStateProvider>();
    web_js_invoke.setContextBuilder(context);
    web_js_invoke.setContextStateProvider(contextState);
    web_js_invoke.setEvalJS(this);
    web_js_invoke.main();

    emitter = getIt<UtilsManager>().emitter;
    callJS('setPlatform', "", ['web']);
    // tell js that dart js loaded
    callJS('dartJSFullyLoaded', "", []);
  }

  @override
  Future<dynamic> callJS(
    String functionName,
    String pageId,
    List<dynamic> args,
  ) async {
    var eventName = UniqueKey().toString();

    js.context["appBridge"].callMethod(
      "emitJSFunction",
      [
        eventName,
        functionName.trim(),
        pageId,
        jsonEncode(args),
      ],
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
  void unmountClientCode(String pagePath) {
    removeClientPage(pagePath);
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

    js.context.callMethod("eval", [pageCode]);
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
    return await callJS("getClientPagelayout", "", [
      projectName,
      {"pagePath": pagePath}
    ]);
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
  void setPageArguments(Map<String, dynamic> args, String pagePath) {}

  @override
  void emitFormActionResponse(String id, data) {
    web_js_invoke.emitFormActionResponse(id, data);
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
