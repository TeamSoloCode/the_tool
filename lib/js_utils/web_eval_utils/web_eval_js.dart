import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;
import 'package:js/js_util.dart';
import 'package:the_tool/js_utils/base_eval_js.dart';
import 'package:the_tool/js_utils/web_eval_utils/web_js_invoke.dart'
    as web_js_invoke;
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:eventify/eventify.dart' as eventify;
import 'package:uuid/uuid.dart';

class EvalJS extends BaseEvalJS {
  var webViewController;
  late ContextStateProvider contextState;
  late eventify.EventEmitter emitter;

  EvalJS({
    this.webViewController,
    required context,
  }) : super(context: context) {
    contextState = getIt<ContextStateProvider>();
    web_js_invoke.setContextBuilder(context);
    web_js_invoke.setContextStateProvider(contextState);
    web_js_invoke.main();

    js.context.callMethod('setPlatform', ['web']);
    emitter = getIt<UtilsManager>().emitter;
  }

  @override
  Future<dynamic> callJS(String functionName, List<dynamic> args) async {
    var eventName = const Uuid().v4();

    js.context["appBridge"].callMethod(
      "emitJSFunction",
      [
        eventName,
        functionName,
        jsonEncode(args),
      ],
    );

    var streamController = StreamController();

    // Event will be call from invoke when js execute is done
    eventify.EventCallback responseFromJS() {
      return (event, context) {
        streamController.add(event.eventData);
      };
    }

    var listener = emitter.on(eventName, context, responseFromJS());
    Future<dynamic> waitingResponseFromJS() async {
      await for (final value in streamController.stream) {
        return value;
      }
    }

    var result = await waitingResponseFromJS();
    var resultObject = jsonDecode(result);
    if (resultObject["error"] != null) {
      throw Exception(resultObject["error"]);
    }

    streamController.close();
    listener.cancel();
    emitter.off(listener);

    return resultObject["data"];
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
  }) async {
    String pageCode = """
      (() => {
        ${getBaseComponentCode(
      pagePath: pagePath,
      clientCode: clientCode,
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

    var promise = web_js_invoke.callAsyncJavaScript(
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
    web_js_invoke.emitFormActionResponse(id, data);
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
