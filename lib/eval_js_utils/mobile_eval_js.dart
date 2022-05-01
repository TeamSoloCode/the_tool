import 'package:flutter/services.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EvalJS extends BaseEvalJS {
  WebViewController? webViewController;
  ContextStateProvider contextStateProvider;

  EvalJS({
    required this.contextStateProvider,
    this.webViewController,
  }) : super(
          contextStateProvider: contextStateProvider,
        );

  @override
  Future<void> executeJS(String jsCode) async {
    webViewController?.runJavascript("context.$jsCode");
  }

  @override
  void setupReactForClientCode(String clientCode) {}

  @override
  void unmountClientCode() {
    String unmountClientCodeJS = """
      const rootEl = document.getElementById("app")
      ReactDOM.unmountComponentAtNode(rootEl);
    """;

    webViewController?.runJavascript("eval($unmountClientCodeJS)");
  }

  Future<String> composeIndexHTML(String clientPageCode) async {
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
      "// <client_code>",
      baseComponentContent,
    );

    replacedContent = replacedContent.replaceAll(
      "// <client_code>",
      clientPageCode,
    );

    return replacedContent;
  }
}
