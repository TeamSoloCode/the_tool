import 'package:flutter/material.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';

abstract class BaseEvalJS {
  ContextStateProvider contextStateProvider;
  BuildContext context;
  bool initialized = false;

  BaseEvalJS({required this.contextStateProvider, required this.context});

  Future<void> executeJS(String jsCode, String pageName);

  Future<String> setupReactForClientCode(String clientCoreCode);

  void unmountClientCode(String pagePath);

  Future<void> executePageCode(String jsCode, String pagePath);

  void setPageArguments(Map<String, dynamic> args, String pagePath);

  void emitFormActionResponse(String id, dynamic data);

  Future<void> registerSubComponent({
    required String parentPagePath,
    required String componentPath,
    required String componentCode,
    String componentPropsAsJSON = "{}",
  });

  String getSubComponentCode({
    required String parentPagePath,
    required String componentPath,
    required String componentCode,
    String componentPropsAsJSON = "{}",
  }) {
    return """
      try {
        const SubComponent = React.memo((props) => {
          const [_contextData, _setContextData] = React.useState(context._data);
          let [didInitState, setDidInitState] = React.useState(false)
          const _prevContextData = usePrevious(_contextData);
          context._updateContextData = _setContextData;
          context._prevData = Object.assign({}, _prevContextData);
          context._data = Object.assign({}, context._data, _contextData);
          
          const [subComponents, _setSubComponent] = React.useState([])
          
          let [pageData, _setPageData] = React.useState({ 
              _tLoaded: true,
              _tIsWeb: context._platform == "web",
              _tIsMobile: context._platform == "mobile",
            },
          )
          const prevPageData = usePrevious(pageData)

          // This will use to set data in layout code
          const setPageData = React.useCallback((data) => {
            const nextData = {...pageData, ...data}
            _setPageData(nextData)

            // To prevent multi call when pageData not update yet
            pageData = nextData;
            setContextData({
              ['$componentPath']: {..._contextData['$componentPath'], ...nextData}
            })
          }, [pageData, _contextData])

          const getPageData = React.useCallback(() => {
            return pageData;
          }, [pageData])

          // Export page context
          const exportPageContext = React.useCallback((exportedContext = {}) => {
            context['$componentPath'] = context['$componentPath'] || {}
            Object.assign(context['$componentPath'], exportedContext)
          }, [pageData])

          const getPageArguments = React.useCallback(() => {
            return context['$componentPath']?._pageArguments || {};
          }, [context['$componentPath']])

          // Use to init state before render the widget
          const useInitState = React.useCallback((initData = {}) => {
            if(!didInitState) {
              Object.assign(pageData, {...initData})
              setDidInitState(true);
            }
          }, [setPageData, didInitState])

          // adding sub component when using t_component
          const registerSubComponent = React.useCallback((newComponent) => {
            const newSubComponents = [...subComponents, newComponent]
            _setSubComponent(newSubComponents)
          }, [subComponents])

          React.useEffect(() => {
            exportPageContext({ setPageData, getPageData, registerSubComponent })
            context['$componentPath'].exportPageContext = exportPageContext
          }, [pageData, setPageData, getPageData, registerSubComponent, exportPageContext])

          React.useEffect(() => {
            logger.log(`Didmount $componentPath`)
            // init data for page
            setTimeout(() => {
              setPageData({_tLoaded: true,})
            })

            return () => {
              logger.log(`Unmounted $componentPath`)
              context['$componentPath'] = {}
              setPageData({})
            }
          }, [])

          $componentCode

          return null;
        })

        context['$parentPagePath'].registerSubComponent(
          React.createElement(
            SubComponent, 
            {
              key: "$componentPath"
            }
          )
        )
      }
      catch(e) {
        console.error(e)
      }
    """;
  }

  String getBaseComponentCode(
      {required String pagePath, required String clientCode}) {
    return """
    try {
      const Main = React.memo((props) => {
        const [_contextData, _setContextData] = React.useState(context._data);
        let [didInitState, setDidInitState] = React.useState(false)
        const _prevContextData = usePrevious(_contextData);
        context._updateContextData = _setContextData;
        context._prevData = Object.assign({}, _prevContextData);
        context._data = Object.assign({}, context._data, _contextData);
        
        const [subComponents, _setSubComponent] = React.useState([])
        
        let [pageData, _setPageData] = React.useState({ 
            _tLoaded: true,
            _tIsWeb: context._platform == "web",
            _tIsMobile: context._platform == "mobile",
          },
        )
        const prevPageData = usePrevious(pageData)

        // This will use to set data in layout code
        const setPageData = React.useCallback((data) => {
          const nextData = {...pageData, ...data}
          _setPageData(nextData)

          // To prevent multi call when pageData not update yet
          pageData = nextData;
          setContextData({
            ['$pagePath']: {..._contextData['$pagePath'], ...nextData}
          })
        }, [pageData, _contextData])

        const getPageData = React.useCallback(() => {
          return pageData;
        }, [pageData])

        // Export page context
        const exportPageContext = React.useCallback((exportedContext = {}) => {
          context['$pagePath'] = context['$pagePath'] || {}
          Object.assign(context['$pagePath'], exportedContext)
        }, [pageData])

        const getPageArguments = React.useCallback(() => {
          return context['$pagePath']?._pageArguments || {};
        }, [context['$pagePath']])

        // Use to init state before render the widget
        const useInitState = React.useCallback((initData = {}) => {
          if(!didInitState) {
            Object.assign(pageData, {...initData})
            setDidInitState(true);
          }
        }, [setPageData, didInitState])

        // adding sub component when using t_component
        const registerSubComponent = React.useCallback((newComponent) => {
          const newSubComponents = [...subComponents, newComponent]
          _setSubComponent(newSubComponents)
        }, [subComponents])

        React.useEffect(() => {
          exportPageContext({ setPageData, getPageData, registerSubComponent })
          context['$pagePath'].exportPageContext = exportPageContext
        }, [pageData, setPageData, getPageData, registerSubComponent, exportPageContext])


        $clientCode

        React.useEffect(() => {
          logger.log(`Didmount $pagePath`)
          // init data for page
          setTimeout(() => {
            setPageData({_tLoaded: true,})
          })

          return () => {
            logger.log(`Unmounted $pagePath`)
            context['$pagePath'] = {}
            setPageData({})
          }
        }, [])

        return subComponents;
      });

      const appEl = document.getElementById("app")

      const clientCodeHost = document.createElement('div');
      clientCodeHost.setAttribute('id', '$pagePath')

      appEl.appendChild(clientCodeHost)

      ReactDOM.render(
        React.createElement(Main, context),
        document.getElementById("$pagePath")
      );
    } catch (err) {
      console.log(err);
    }
    """;
  }

  String _commonBaseComponentCode(String pagePath) {
    return """

    """;
  }
}
