import 'dart:convert';
import 'dart:js' as js;
import 'package:js/js_util.dart';
import 'package:the_tool/eval_js_utils/base_eval_js.dart';
import 'package:the_tool/eval_js_utils/web_eval_utils/web_js_invoke.dart'
    as webjs;
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/utils.dart';

class EvalJS extends BaseEvalJS {
  var webViewController;
  EvalJS({
    this.webViewController,
    required context,
  }) : super(context: context) {
    webjs.setContextBuilder(context);
    webjs.setContextStateProvider(getIt<ContextStateProvider>());
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
  Future<dynamic> executeJS(String jsCode, String pagePath) async {
    var index = jsCode.indexOf('(');

    var isFunctionInContext = await js.context.callMethod(
      "eval",
      [
        "isFunctionExistsOnContext('${jsCode.substring(0, index)}', '$pagePath')"
      ],
    );

    var code = jsCode;
    if (isFunctionInContext == 1) {
      code = "context['$pagePath'].$jsCode";
    }

    var promise = webjs.callAsyncJavaScript(
      """(async () => {
        const { _pageData, getPageData } = context['$pagePath'] ?? {}

        const returnedValue = await $code 
        if(_.isPlainObject(returnedValue)) {
          return JSON.stringify(returnedValue)
        }
        return returnedValue;
      })()""",
    );

    var result = await promiseToFuture(promise);

    if (result is String) {
      // This is because promiseToFuture return LegacyJavaScriptObject
      // that can't be parse to Dart's Map
      try {
        return json.decode(result);
      } catch (err) {
        return result;
      }
    }
    return result;
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
    Map<dynamic, dynamic> componentPropsAsJSON = const {},
    Map<dynamic, dynamic> computedComponentPropsAsJSON = const {},
  }) async {
    String subComponentCode = getRegisterComponentCode(
      parentPagePath: parentPagePath,
      componentPath: componentPath,
      componentCode: componentCode,
      componentPropsAsJSON: json.encode(componentPropsAsJSON),
    );

    js.context.callMethod("eval", [subComponentCode]);
  }

  @override
  Future<void> unregisterSubComponent({
    required String parentPagePath,
    required String componentPath,
  }) async {
    js.context.callMethod(
      "eval",
      [
        getUnregisterComponentCode(
          parentPagePath: parentPagePath,
          componentPath: componentPath,
        )
      ],
    );
  }
}
