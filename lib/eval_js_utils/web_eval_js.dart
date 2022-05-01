import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'dart:js' as js;
import 'package:the_tool/eval_js_utils/web_js_invoke.dart' as webjs;
import 'package:the_tool/page_utils/context_state_provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

class EvalJS extends BaseEvalJS {
  WebViewController? webViewController;
  ContextStateProvider contextStateProvider;

  EvalJS({required this.contextStateProvider, this.webViewController})
      : super(
          contextStateProvider: contextStateProvider,
        ) {
    webjs.setContextStateProvider(contextStateProvider);
    webjs.main();
    js.context['context'].callMethod('setPlatform', ['web']);
  }

  @override
  void unmountClientCode() {
    String unmountClientCodeJS = """
      const rootEl = document.getElementById("app")
      ReactDOM.unmountComponentAtNode(rootEl);
    """;

    js.context.callMethod("eval", [unmountClientCodeJS]);
  }

  @override
  void setupReactForClientCode(String clientCode) {
    String componentContent = """
    (() => {
      $baseComponentContent
    })()
    """;

    componentContent = componentContent.replaceAll(
      "// <client_code>",
      clientCode,
    );

    js.context.callMethod("eval", [componentContent]);
  }

  @override
  Future<void> executeJS(String jsCode) async {
    // TODO: implement executeJS
    js.context.callMethod("eval", ["context.$jsCode"]);
  }

  @override
  Future<String> composeIndexHTML(String clientPageCode) {
    throw UnimplementedError();
  }
}
