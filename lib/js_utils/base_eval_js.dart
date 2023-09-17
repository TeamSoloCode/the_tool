import 'dart:convert';

import 'package:modular_core/modular_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class BaseEvalJS {
  BuildContext context;
  bool initialized = false;

  BaseEvalJS({required this.context});

  void unmountClientCode(String pagePath);

  Future<void> executePageCode({
    required String clientCode,
    required String pagePath,
  });

  void setPageArguments(Map<String, dynamic> args, String pagePath);
  void emitFormActionResponse(String id, dynamic data);

  /// Will call js side and load js bundle for page code
  void addClientPage(String pagePath);

  /// Will call js side to load js bundle for page layout
  Future<Map<String, dynamic>?> getClientPageLayout(String pagePath);

  /// Will call js side and remove react component of the disposed page
  void removeClientPage(String pagePath);

  String getRegisterComponentCode({
    required String parentPagePath,
    required String componentPath,
    required String componentCode,
    String componentPropsAsJSON = "{}",
    String computedComponentPropsAsJSON = "{}",
  }) {
    return """

      try {
        const SubComponent = React.memo((props) => {
          const prevProps = usePrevious(props)
          React.useEffect(() => {
            if(prevProps && !_.isEqual(prevProps, props)) {
              setPageData({props: {...props}})
            }
          }, [props, prevProps])

    ${_commonBaseComponentCode(
      pagePath: componentPath,
      clientCode: componentCode,
    )}
        /** Do not add code under this area*/

        })
        
        const rawComponentProps = JSON.parse('$componentPropsAsJSON' || "{}")
        const computedComponentProps = JSON.parse('$computedComponentPropsAsJSON' || "{}")
        const _appBase = appBridge.getAppBase()
        /** Add subcomponent into parent component by its register function */
        _.get(
            _appBase.getContextData(), 
            `$parentPagePath.registerSubComponent`
          )?.(
              "$componentPath", 
              SubComponent, 
              rawComponentProps, 
              computedComponentProps
            )
         
      }
      catch(e) {
        console.log(`Error: \${JSON.stringify(e)}`)
        console.error(e)
      }
    """;
  }

  String getBaseComponentCode({
    required String pagePath,
    required String clientCode,
  }) {
    return """
    try {
      const Main = React.memo((props) => {
    ${_commonBaseComponentCode(
      pagePath: pagePath,
      clientCode: clientCode,
    )}
        /** Do not add code under this area*/
      });

      const appEl = document.getElementById("app")

      const clientCodeHost = document.createElement('div');
      clientCodeHost.setAttribute('id', '$pagePath')

      appEl.appendChild(clientCodeHost)

      ReactDOM.render(
        React.createElement(Main, {}),
        document.getElementById("$pagePath")
      );
    } catch (err) {
      console.log(`Error: \${JSON.stringify(err)}`)
      console.error(err);
    }
    """;
  }

  String _commonBaseComponentCode({
    required String pagePath,
    required String clientCode,
  }) {
    // pageArguments?.data?.data: This because when use RouteGuard the pageArguments?.data is ModularArguments
    final pageArgumentsData = jsonEncode(Modular.args.data is ModularArguments
        ? Modular.args.data?.data
        : Modular.args.data ?? {});

    final uriParams = jsonEncode(Modular.args.params);
    final queryParams = jsonEncode(Modular.args.queryParams);

    return """
        const [_appBase] = React.useState(appBridge.getAppBase())
        const [_contextData, _setContextData] = React.useState(_appBase.getContextData());

        const [__route] = React.useState({
          pageArguments: JSON.parse('$pageArgumentsData'),
          params: JSON.parse('$uriParams'),
          queryParams: JSON.parse('$queryParams'),
          currentPath: '${Modular.to.path}'
        })

        let [_didInitState] = React.useState(false)
        const _prevContextData = usePrevious(_contextData);
        
        const isMounted = hooks.useIsMounted()

        const [\$mediaQuery, _updateMediaQuery] = React.useState(null)
        const [\$themeData, _setThemeData] = React.useState(null)

        const [_subComponents, _setSubComponent] = React.useState([])
        const [_unregisterSubComponents, _updateUnregisterSubComponent] = React.useState([])
        const _debounceUnregisterSubComponent = hooks.useDebounce(_unregisterSubComponents, 200)
        const _debounceRegisterSubComponent = hooks.useDebounce(_subComponents, 10)
        
        let [_pageData, _setPageData] = React.useState({ 
            _tLoaded: true,
            _tIsWeb: _contextData._platform == "web",
            _tIsMobile: _contextData._platform == "mobile",

            /** add props from parent page into pageData */
            props
          },
        )

        const [_nextState, setPageData] = React.useState({})
        const _prevState = usePrevious(_nextState);
        const prevPageData = usePrevious(_pageData)

        // This function will update data into context and component state
        const updatePageData = React.useCallback((data) => {
          const nextData = {..._pageData }
          Object.entries(data).forEach(([key, value]) => {
            _.set(nextData, key, value)
          })

          _setPageData(nextData)

          // To prevent multi call when pageData not update yet
          _pageData = nextData;

          const updatedData = {..._contextData['$pagePath'], ...nextData}
          _appBase.setContextData({
            ['$pagePath']: _.isEmpty(updatedData) ? null : updatedData
          })
        }, [_pageData, _appBase, _contextData])

        React.useEffect(() => {
          updatePageData(_nextState)
        }, [_nextState])

        const getPageData = React.useMemo(() => {
          return () => _pageData;
        }, [_pageData])

        const \$root = React.useMemo(() => {
          return _pageData;
        }, [_pageData])

        // Export page context
        const exportPageContext = React.useCallback((exportedContext = {}) => {
          _contextData['$pagePath'] = _contextData['$pagePath'] || {}
          Object.assign(_contextData['$pagePath'], exportedContext)
        }, [_pageData])

        const getRoute = React.useCallback(() => {
          return __route;
        }, [__route])

        // Use to init state before render the widget
        const useInitState = React.useCallback((initData = {}) => {
          if(!_didInitState) {
            Object.assign(_pageData, {...initData})
            _didInitState = true;
          }
        }, [_didInitState])

        const request = React.useCallback((path, options = {}) => {
          return _appBase.request(path, options)
        }, [_appBase.request])

        const _debouceRegisterSubComponent = React.useMemo(() => {
          return _.debounce((subComponents) => {
            _setSubComponent([...subComponents])
          }, 10)
        }, [])

        // adding sub component when using t_component
        const registerSubComponent = (
          subComponentName, 
          newComponent, 
          rawComponentProps,
          computedComponentProps,
        ) => {
          _subComponents.push({
            subComponentName, 
            newComponent, 
            rawComponentProps, 
            computedComponentProps
          })
          // Debounce to avoid re-render
          _debouceRegisterSubComponent(_subComponents)
        }

        const _debouceUnregisterSubComponent = React.useMemo(() => {
          return _.debounce((unregisterSubComponents) => {
            _updateUnregisterSubComponent([...unregisterSubComponents])
          }, 200)
        }, [])
        
        const _unregisterSubComponent = React.useCallback(
          (unregisterComponentName) => 
        {
          _unregisterSubComponents.push(unregisterComponentName)
          // Debounce to avoid re-render
          _debouceUnregisterSubComponent(_unregisterSubComponents)
        }, 
          [_unregisterSubComponents]
        )

        React.useEffect(() => {
          if(_unregisterSubComponents.length == 0) return
          const updatedSubComponents = (_subComponents || []).filter((comp) => {
            return !_unregisterSubComponents.includes(comp.subComponentName);
          })

          _setSubComponent(updatedSubComponents)
          _updateUnregisterSubComponent([])
        }, [_debounceUnregisterSubComponent])

        const subComponents = React.useMemo(() => {
          return _subComponents
        }, [_debounceRegisterSubComponent])

        const __emitEvent__ = React.useCallback( async (eventName, actionName) => {
          const actionId = uuidv4();
          const promiseResult = new Promise((resolve) => {
            webJSChannel.once(actionId, (data) => {
              const { result } = JSON.parse(data);
              resolve(result);
            });
          });
          _appBase.dispatchFormAction(eventName, actionId, actionName);
          return promiseResult;
        }, [])

        const validateForm = React.useCallback(async (formName) => {
          return __emitEvent__(`form:$pagePath:\${formName}`, "validate")
        }, [__emitEvent__])

        const toggleChangeTheme = React.useCallback(() => {
          _appBase.toggleChangeTheme()
        }, [_appBase.toggleChangeTheme])

        const setCookies = React.useCallback((key, value) => {
          _appBase.setCookies(key, value)
        }, [_appBase.setCookies])

        const getCookies = React.useCallback((key, defaultValue) => {
          return _appBase.getCookies(key, defaultValue)
        }, [_appBase.getCookies])

        const setRouteAuth = React.useCallback((routeAuth) => {
          return _appBase.setRouteAuth(routeAuth)
        }, [_appBase.setRouteAuth])

        const _onDebounceMediaQuery = React.useMemo(() => {
          return _.debounce((mediaQueryData) => {
            _updateMediaQuery(mediaQueryData)
          }, 200)
        }, [])

        const _onMediaQueryChanged = React.useCallback(
        ({ 
            width, 
            height, 
            orientation
        }) => {
          _onDebounceMediaQuery({ width, height, orientation })
        }, [_onDebounceMediaQuery])

        // export pages util function
        React.useEffect(() => {
          exportPageContext({
            _onMediaQueryChanged,
            _unregisterSubComponent,

            validateForm,
            setPageData,
            getPageData,
            registerSubComponent,
          })
          _contextData['$pagePath'].exportPageContext = exportPageContext
        }, [
          _unregisterSubComponent,
          _onMediaQueryChanged,

          setPageData,
          getPageData,
          registerSubComponent,
          exportPageContext,
          validateForm,
        ])

        React.useEffect(() => {
          if (isMounted()) {
            // init data for page
            setPageData({ _tLoaded: true })
          }
        }, [isMounted])

        //==========================Start Page Code==========================================

        $clientCode

        //==========================End Page Code============================================

        React.useEffect(() => {
          logger.log(`Didmount $pagePath`)
          return () => {
            logger.log(`Unmounted $pagePath`)
            _appBase.setContextData({
              ['$pagePath']: null
            })
            setPageData(null)
          }
        }, [])

        return subComponents.map(({ 
          subComponentName, 
          newComponent, 
          rawComponentProps 
        }) => {
          
          const componentProps = Object.entries(rawComponentProps)
            .reduce((result, [key, value]) => {
              let propFromParentContext = _.get(_contextData, `$pagePath.\${value}`)
              
              result[key] = propFromParentContext != undefined ? propFromParentContext : value

              if(value && _appBase.isValueBinding(value)) {
                let propsFromParentData = _appBase.getBindingValue(getPageData(), value)

                /** 
                 * If the props not in parent data then we 
                 * will get from parent context 
                 */
                if(!propsFromParentData) {
                  propsFromParentData = _appBase.getBindingValue(
                    _.get(_contextData, '$pagePath'), 
                    value
                  )
                }

                result[key] =  propsFromParentData
              }

              return result
            }, {})

          return React.createElement(
            "div",
            {
              id: `\${subComponentName}`,
              key: `\${subComponentName}`,
            },
            React.createElement(
              newComponent, 
              {
                key: `\${subComponentName}`,
                ...componentProps
              }
            )
          )
        })
    """;
  }

  Future<void> registerSubComponent({
    required String parentPagePath,
    required String componentPath,
    required String componentCode,
    Map<dynamic, dynamic> componentPropsAsJSON = const {},
  });

  Future<void> unregisterSubComponent({
    required String parentPagePath,
    required String componentPath,
  }) async {
    callJS("_unregisterSubComponent", parentPagePath, [componentPath]);
  }

  Future<dynamic> callJS(
    String functionName,
    String pageId,
    List<dynamic> args,
  );
}
