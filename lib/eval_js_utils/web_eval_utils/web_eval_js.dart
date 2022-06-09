import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'dart:js' as js;
import 'package:the_tool/eval_js_utils/web_eval_utils/web_js_invoke.dart'
    as webjs;
import 'package:the_tool/page_utils/context_state_provider.dart';

class EvalJS extends BaseEvalJS {
  InAppWebViewController? webViewController;
  EvalJS({
    required contextStateProvider,
    this.webViewController,
    required context,
  }) : super(contextStateProvider: contextStateProvider, context: context) {
    webjs.setContextBuilder(context);
    webjs.setContextStateProvider(contextStateProvider);
    webjs.main();
    js.context.callMethod('setPlatform', ['web']);
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

    js.context.callMethod("eval", [pageCode]);
  }

  @override
  Future<String> setupReactForClientCode(
    String clientCoreCode,
  ) async {
    js.context.callMethod("eval", [clientCoreCode]);

    return Future.value("");
  }

  @override
  Future<void> executeJS(String jsCode, String pageName) async {
    var index = jsCode.indexOf('(');

    var isFunctionInContext = await js.context.callMethod(
      "eval",
      [
        "isFunctionExistsOnContext('${jsCode.substring(0, index)}', '$pageName')"
      ],
    );

    if (isFunctionInContext == 1) {
      js.context.callMethod("eval", ["context['$pageName'].$jsCode"]);
    } else {
      js.context.callMethod("eval", [jsCode]);
    }
  }

  @override
  void setPageArguments(Map<String, dynamic> args, String pagePath) {}
}
