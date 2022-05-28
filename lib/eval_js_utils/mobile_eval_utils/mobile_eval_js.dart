import 'package:flutter/material.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EvalJS extends BaseEvalJS {
  WebViewController? webViewController;
  ContextStateProvider contextStateProvider;
  BuildContext context;

  String _vendorContent = "";
  String _appContent = "";
  String _fileContent = "";

  EvalJS({
    required this.contextStateProvider,
    this.webViewController,
    required this.context,
  }) : super(
          contextStateProvider: contextStateProvider,
          context: context,
        );

  @override
  Future<void> executeJS(String jsCode, String pagePath) async {
    var index = jsCode.indexOf('(');

    var isFunctionInContext =
        await webViewController?.runJavascriptReturningResult(
      "isFunctionExistsOnContext('${jsCode.substring(0, index)}', '$pagePath')",
    );

    if (isFunctionInContext == "1") {
      webViewController?.runJavascript("context['$pagePath'].$jsCode");
    } else {
      webViewController?.runJavascript(jsCode);
    }
  }

  @override
  Future<void> executePageCode(
    String clientCode,
    String pagePath,
  ) async {
    String pageCode = """
      (() => {
        ${getBaseComponentCode(pagePath)}
      })()
      """;

    pageCode = pageCode.replaceAll(
      "// <client_code>",
      clientCode,
    );

    webViewController?.runJavascript(pageCode);
  }

  @override
  Future<String> setupReactForClientCode(
    String clientCode,
    String clientCoreCode,
    String pagePath,
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
      ReactDOM.unmountComponentAtNode(rootEl);
    })()
    """;
    webViewController?.runJavascript(unmountClientCodeJS);
  }

  @override
  void setPageArguments(Map<String, dynamic> args, String pagePath) {
    // webViewController?.runJavascript("context['$pagePath']._ = args;");
  }
}
