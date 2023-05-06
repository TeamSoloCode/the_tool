import 'dart:convert';
import 'dart:js' as js;
import 'package:js/js_util.dart';
import 'package:the_tool/js_utils/base_eval_js.dart';
import 'package:the_tool/js_utils/web_eval_utils/web_js_invoke.dart' as webjs;
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:modular_core/modular_core.dart';

class EvalJS extends BaseEvalJS {
  var webViewController;
  late ContextStateProvider contextState;
  EvalJS({
    this.webViewController,
    required context,
  }) : super(context: context) {
    contextState = getIt<ContextStateProvider>();
    webjs.setContextBuilder(context);
    webjs.setContextStateProvider(contextState);
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
  Future<void> executePageCode({
    required String clientCode,
    required String pagePath,
    ModularArguments? pageArguments,
  }) async {
    String pageCode = """
      (() => {
        ${getBaseComponentCode(
      pagePath: pagePath,
      clientCode: clientCode,
      pageArguments: pageArguments,
    )}
      })()
      """;

    js.context.callMethod("eval", [pageCode]);
  }

  @override
  Future<dynamic> executeAsyncJS(String jsCode, String pagePath) async {
    var index = jsCode.indexOf('(');

    var isFunctionInContext = js.context.callMethod(
        "isFunctionExistsOnContext", [jsCode.substring(0, index), pagePath]);

    var code = jsCode;
    if (isFunctionInContext == 1) {
      code = "context['$pagePath'].$jsCode";
    }

    var promise = webjs.callAsyncJavaScript(
      """(async () => {
        const { _pageData, getPageData, _onMediaQueryChanged } = context['$pagePath'] ?? {}

        const returnedValue = await $code 
        if(_.isPlainObject(returnedValue) || _.isArrayLikeObject(returnedValue)) {
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