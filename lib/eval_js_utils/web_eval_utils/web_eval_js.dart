import 'package:flutter/material.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'dart:js' as js;
import 'package:the_tool/eval_js_utils/web_eval_utils/web_js_invoke.dart'
    as webjs;
import 'package:the_tool/page_utils/context_state_provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

class EvalJS extends BaseEvalJS {
  WebViewController? webViewController;
  ContextStateProvider contextStateProvider;
  BuildContext context;
  EvalJS(
      {required this.contextStateProvider,
      this.webViewController,
      required this.context})
      : super(contextStateProvider: contextStateProvider, context: context) {
    webjs.setContextBuilder(context);
    webjs.setContextStateProvider(contextStateProvider);
    webjs.main();
    js.context['context'].callMethod('setPlatform', ['web']);
  }

  @override
  void unmountClientCode(String pagePath) {
    String unmountClientCodeJS = """
      const rootEl = document.getElementById("$pagePath")
      ReactDOM.unmountComponentAtNode(rootEl);
    """;

    js.context.callMethod("eval", [unmountClientCodeJS]);
  }

  @override
  Future<String> setupReactForClientCode(
    String clientCode,
    String clientCoreCode,
    String pagePath,
  ) {
    String componentContent = """
    // <client_core_code>
    (() => {
      ${getBaseComponentCode(pagePath)}
    })()
    """;

    componentContent = componentContent.replaceAll(
      "// <client_code>",
      clientCode,
    );

    componentContent = componentContent.replaceAll(
      "// <client_core_code>",
      clientCoreCode,
    );

    js.context.callMethod("eval", [componentContent]);

    return Future.value("");
  }

  @override
  Future<void> executeJS(String jsCode) async {
    print(js.context);
    // TODO: implement executeJS
    js.context.callMethod("eval", ["context.$jsCode"]);
  }
}
