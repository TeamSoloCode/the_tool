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
      try {
        const Main = React.memo((props) => {
          const [_contextData, _setContextData] = React.useState(context._data);
          const _prevContextData = context.usePrevious(_contextData);
          context._updateContextData = _setContextData;
          context._prevData = Object.assign({}, _prevContextData);
          context._data = Object.assign({}, context._data, _contextData);
          
          React.useEffect(() => {
            console.log("abcd _contextData" , _contextData)
            console.log("abcd context._data" , context._data)
            console.log("abcd _prevContextData" , _prevContextData)
            console.log("abcd context._prevData" , context._prevData)
          }, [_contextData])

          React.useEffect(() => {
            return () => {
              console.log("abcd component unmounted")
            }
          }, [])

          // <client_code>

          return null;
        });

        ReactDOM.render(
          React.createElement(Main, context._data),
          document.getElementById("app")
        );
      } catch (err) {
        console.log(err);
      }
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
}
