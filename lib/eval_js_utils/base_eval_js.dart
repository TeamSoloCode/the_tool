import 'package:the_tool/page_utils/context_state_provider.dart';

abstract class BaseEvalJS {
  ContextStateProvider contextStateProvider;
  BaseEvalJS({required this.contextStateProvider});

  Future<void> executeJS(String jsCode);
  void setupReactForClientCode(String clientCode);
  void unmountClientCode();
  Future<String> composeIndexHTML(String clientPageCode);

  String baseComponentContent = """
    try {
      const Main = React.memo((props) => {
        const [_contextData, _setContextData] = React.useState(context._data);
        const _prevContextData = context.usePrevious(_contextData);
        context._updateContextData = _setContextData;
        context._prevData = Object.assign({}, _prevContextData);
        context._data = Object.assign({}, context._data, _contextData);
        
        // React.useEffect(() => {
        //   console.log("abcd _contextData" , _contextData)
        //   console.log("abcd context._data" , context._data)
        //   console.log("abcd _prevContextData" , _prevContextData)
        //   console.log("abcd context._prevData" , context._prevData)
        // }, [_contextData])

        // React.useEffect(() => {
        //   return () => {
        //     console.log("abcd component unmounted")
        //   }
        // }, [])

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
    """;
}
