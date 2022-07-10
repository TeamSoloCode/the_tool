import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'dart:js' as js;
import 'package:the_tool/eval_js_utils/web_eval_utils/web_js_invoke.dart'
    as webjs;

class EvalJS extends BaseEvalJS {
  var webViewController;
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
      const appEl = document.getElementById("app")
      appEl.removeChild(rootEl);
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
        ${getBaseComponentCode(pagePath: pagePath, clientCode: clientCode)}
      })()
      """;

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

  @override
  void emitFormActionResponse(String id, data) {
    webjs.emitFormActionResponse(id, data);
  }

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

    js.context.callMethod("eval", [subComponentCode]);
  }

  @override
  Future<void> unregisterSubComponent({
    required String parentPagePath,
    required String componentPath,
  }) async {
    String unregisterCode = """
      const componentEl = document.getElementById("$componentPath")
      const rootEl = document.getElementById("$parentPagePath")
      rootEl.removeChild(componentEl);
      ReactDOM.unmountComponentAtNode(componentEl);
    """;
  }
}
