import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_js_invoke.dart'
    as mobilejs;

class EvalJS extends BaseEvalJS {
  InAppWebViewController? webViewController;

  EvalJS({
    required contextStateProvider,
    this.webViewController,
    required context,
  }) : super(
          contextStateProvider: contextStateProvider,
          context: context,
        ) {
    mobilejs.main();
    mobilejs.registerJavascriptHandler(
      context,
      contextStateProvider,
      webViewController,
    );
  }

  @override
  Future<void> executeJS(String jsCode, String pagePath) async {
    var index = jsCode.indexOf('(');

    var isFunctionInContext = await webViewController?.evaluateJavascript(
      source:
          "isFunctionExistsOnContext('${jsCode.substring(0, index)}', '$pagePath')",
    );

    if (isFunctionInContext == 1) {
      webViewController?.evaluateJavascript(
        source: "context['$pagePath'].$jsCode",
      );
    } else {
      webViewController?.evaluateJavascript(source: jsCode);
    }
  }

  @override
  Future<void> executePageCode(
    String clientCode,
    String pagePath,
  ) async {
    String pageCode = """
      (() => {
        ${getBaseComponentCode(pagePath: pagePath, clientCode: clientCode)}
      })()
      """;

    webViewController?.evaluateJavascript(source: pageCode);
  }

  @override
  Future<String> setupReactForClientCode(
    String clientCoreCode,
  ) async {
    var staticContent = getIt<UtilsManager>().staticContent;

    String vendorContent = staticContent["vendor"];
    String appContent = staticContent["app"];
    String fileContent = staticContent["htmlContent"];

    String replacedContent = fileContent.replaceAll(
      "// <vendor_code>",
      vendorContent,
    );

    replacedContent = replacedContent.replaceAll(
      "// <app_code>",
      appContent,
    );

    replacedContent = replacedContent.replaceAll(
      "// <client_core_code>",
      clientCoreCode,
    );

    return replacedContent;
  }

  @override
  void unmountClientCode(String pagePath) {
    String unmountClientCodeJS = """
    (() => {
      const rootEl = document.getElementById("$pagePath")
      const appEl = document.getElementById("app")
      appEl.removeChild(rootEl);
      ReactDOM.unmountComponentAtNode(rootEl);
    })()
    """;
    webViewController?.evaluateJavascript(source: unmountClientCodeJS);
  }

  @override
  void setPageArguments(Map<String, dynamic> args, String pagePath) {
    // webViewController?.runJavascript("context['$pagePath']._ = args;");
  }

  @override
  void emitFormActionResponse(String id, data) {}

  @override
  Future<void> registerSubComponent({
    required String parentPagePath,
    required String componentPath,
    required String componentCode,
    String componentPropsAsJSON = "{}",
  }) async {
    String subComponentCode = getSubComponentCode(
      parentPagePath: parentPagePath,
      componentPath: componentPath,
      componentCode: componentCode,
    );

    webViewController?.evaluateJavascript(source: subComponentCode);
  }

  @override
  Future<void> unregisterSubComponent(
      {required String parentPagePath, required String componentPath}) async {}
}
