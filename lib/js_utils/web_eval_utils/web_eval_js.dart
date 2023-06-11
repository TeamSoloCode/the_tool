import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;
import 'package:the_tool/js_utils/base_eval_js.dart';
import 'package:the_tool/js_utils/web_eval_utils/web_js_invoke.dart'
    as web_js_invoke;
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:eventify/eventify.dart' as eventify;

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
    web_js_invoke.setEvalJS(this);
    web_js_invoke.main();

    emitter = getIt<UtilsManager>().emitter;
    callJS('setPlatform', "", ['web']);
  }

  @override
  Future<dynamic> callJS(
    String functionName,
    String pageId,
    List<dynamic> args,
  ) async {
    var eventName = DateTime.now().millisecondsSinceEpoch.toString();

    js.context["appBridge"].callMethod(
      "emitJSFunction",
      [
        eventName,
        functionName.trim(),
        pageId,
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
