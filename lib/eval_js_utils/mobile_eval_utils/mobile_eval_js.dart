import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_js_invoke.dart'
    as mobilejs;

class EvalJS extends BaseEvalJS {
  InAppWebViewController? webViewController;

  EvalJS({
    this.webViewController,
    required context,
  }) : super(
          context: context,
        ) {
    mobilejs.main();
    mobilejs.registerJavascriptHandler(
      context,
      getIt<ContextStateProvider>(),
      webViewController,
    );
  }

  @override
  Future<dynamic> executeJS(String jsCode, String pagePath) async {
    var index = jsCode.indexOf('(');

    var isFunctionInContext = await webViewController?.evaluateJavascript(
      source:
          "isFunctionExistsOnContext('${jsCode.substring(0, index)}', '$pagePath')",
    );

    var code = jsCode;
    if (isFunctionInContext == 1) {
      code = "context['$pagePath'].$jsCode";
    }

    var result = await webViewController?.callAsyncJavaScript(
      functionBody: """return await (async () => {
        const { pageData, getPageData } = context['$pagePath'] ?? {}

        const returnedValue = await $code 
        return returnedValue;
      })()""",
    );

    return result?.value;
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

    String vendorContent = staticContent["vendor"] ?? "";
    String appContent = staticContent["app"] ?? "";
    String fileContent = staticContent["htmlContent"] ?? "";

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
    Map<dynamic, dynamic> componentPropsAsJSON = const {},
    Map<dynamic, dynamic> computedComponentPropsAsJSON = const {},
  }) async {
    String subComponentCode = getRegisterComponentCode(
      parentPagePath: parentPagePath,
      componentPath: componentPath,
      componentCode: componentCode,
      componentPropsAsJSON: json.encode(componentPropsAsJSON),
      computedComponentPropsAsJSON: json.encode(computedComponentPropsAsJSON),
    );

    webViewController?.evaluateJavascript(source: subComponentCode);
  }

  @override
  Future<void> unregisterSubComponent({
    required String parentPagePath,
    required String componentPath,
  }) async {
    webViewController?.evaluateJavascript(
      source: getUnregisterComponentCode(
        parentPagePath: parentPagePath,
        componentPath: componentPath,
      ),
    );
  }
}
