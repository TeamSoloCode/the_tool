import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EvalJS extends BaseEvalJS {
  WebViewController? webViewController;
  ContextStateProvider contextStateProvider;
  BuildContext context;
  EvalJS({
    required this.contextStateProvider,
    this.webViewController,
    required this.context,
  }) : super(
          contextStateProvider: contextStateProvider,
          context: context,
        );

  @override
  Future<void> executeJS(String jsCode) async {
    webViewController?.runJavascript("context.$jsCode");
  }

  @override
  Future<String> setupReactForClientCode(
    String clientCode,
    String clientCoreCode,
    String pagePath,
  ) async {
    String vendorContent =
        await rootBundle.loadString('js-module/dist/vendors.js');
    String appContent = await rootBundle.loadString('js-module/dist/app.js');
    String fileContent =
        await rootBundle.loadString('js-module/dist/index.html');

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

    replacedContent = replacedContent.replaceAll(
      "// <client_code>",
      getBaseComponentCode(pagePath),
    );

    replacedContent = replacedContent.replaceAll(
      "// <client_code>",
      clientCode,
    );

    return replacedContent;
  }

  @override
  void unmountClientCode(String pagePath) {
    String unmountClientCodeJS = """
      const rootEl = document.getElementById("$pagePath")
      ReactDOM.unmountComponentAtNode(rootEl);
    """;

    webViewController?.runJavascript("eval($unmountClientCodeJS)");
  }
}
