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

  createWebView() {
    WebView();
  }

  @override
  Future<void> executeJS(String jsCode) async {
    webViewController?.runJavascript("context.$jsCode");
  }
}
