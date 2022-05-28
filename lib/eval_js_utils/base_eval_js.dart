import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';

abstract class BaseEvalJS {
  ContextStateProvider contextStateProvider;
  BuildContext context;
  BaseEvalJS({required this.contextStateProvider, required this.context});

  Future<void> executeJS(String jsCode, String pageName);
  Future<String> setupReactForClientCode(
      String clientCode, String clientCoreCode, String pagePath);
  void unmountClientCode(String pagePath);
  Future<void> executePageCode(String jsCode, String pagePath);

  bool initialized = false;

  String getBaseComponentCode(String pagePath) {
    return """
    try {
      const Main = React.memo((props) => {
        const [_contextData, _setContextData] = React.useState(context._data);
        const _prevContextData = usePrevious(_contextData);
        context._updateContextData = _setContextData;
        context._prevData = Object.assign({}, _prevContextData);
        context._data = Object.assign({}, context._data, _contextData);
        
        const [_pageData, _setPageData] = React.useState({})

        // This will use to set data in layout code
        const setPageData = React.useCallback((data) => {
          const nextData = {..._pageData, ...data}
          _setPageData(nextData)
          setContextData({['$pagePath']: {...nextData}})
        }, [_pageData])

        const getPageData = React.useCallback(( ) => {
          return _pageData;
        }, [_pageData])

        // Export page context
        const exportPageContext = React.useCallback((exportedContext = {}) => {
          context['$pagePath'] = context['$pagePath'] || {}
          Object.assign(context['$pagePath'], exportedContext)
        }, [_pageData])

        React.useEffect(() => {
          exportPageContext({ setPageData, getPageData })
        }, [_pageData, setPageData])

        React.useEffect(() => {
          logger.log(`Didmount $pagePath`)
          return () => {
            logger.log(`Unmounted $pagePath`)
            context['$pagePath'] = {}
          }
        }, [])

        // <client_code>

        return null;
      });

      const appEl = document.getElementById("app")

      const clientCodeHost = document.createElement('div');
      clientCodeHost.setAttribute('id', '$pagePath')

      appEl.appendChild(clientCodeHost)

      ReactDOM.render(
        React.createElement(Main, context._data),
        document.getElementById("$pagePath")
      );
    } catch (err) {
      console.log(err);
    }
    """;
  }
}
