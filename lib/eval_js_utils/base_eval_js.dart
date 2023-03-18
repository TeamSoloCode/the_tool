import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

abstract class BaseEvalJS {
  BuildContext context;
  bool initialized = false;

  BaseEvalJS({required this.context});

  Future<dynamic> executeJS(String jsCode, String pagePath);

  Future<String> setupReactForClientCode(String clientCoreCode);

  void unmountClientCode(String pagePath);

  Future<void> executePageCode(String clientCode, String pagePath);

  void setPageArguments(Map<String, dynamic> args, String pagePath);

  void emitFormActionResponse(String id, dynamic data);

  Future<void> registerSubComponent({
    required String parentPagePath,
    required String componentPath,
    required String componentCode,
    Map<dynamic, dynamic> componentPropsAsJSON = const {},
  });

  Future<void> unregisterSubComponent({
    required String parentPagePath,
    required String componentPath,
  });

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
        
        /** Add subcomponent into parent component by its register function */
        _.get(
            context, 
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
        React.createElement(Main, context),
        document.getElementById("$pagePath")
      );
    } catch (err) {
      console.log(`Error: \${JSON.stringify(err)}`)
      console.error(err);
    }
    """;
  }

  String _commonBaseComponentCode(
      {required String pagePath, required String clientCode}) {
    return """
        const [_contextData, _setContextData] = React.useState(context._data);
        let [didInitState, setDidInitState] = React.useState(false)
        const _prevContextData = usePrevious(_contextData);
        context._updateContextData = _setContextData;
        context._prevData = Object.assign({}, _prevContextData);
        context._data = Object.assign({}, context._data, _contextData);
        
        const isMounted = hooks.useIsMounted()
        const [_subComponents] = React.useState([])
        const [_updateSubComponentToken, _setUpdateSubComponentToken] = React.useState()
        const [\$mediaQuery, _updateMediaQuery] = React.useState(null)
        const [\$themeData, _setThemeData] = React.useState(null)
        
        let [_pageData, _setPageData] = React.useState({ 
            _tLoaded: true,
            _tIsWeb: context._platform == "web",
            _tIsMobile: context._platform == "mobile",

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
          setContextData({
            ['$pagePath']: _.isEmpty(updatedData) ? null : updatedData
          })
        }, [_pageData, _contextData])

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
          context['$pagePath'] = context['$pagePath'] || {}
          Object.assign(context['$pagePath'], exportedContext)
        }, [_pageData])

        const getPageArguments = React.useCallback(() => {
          return context['$pagePath']?._pageArguments || {};
        }, [context['$pagePath']])

        // Use to init state before render the widget
        const useInitState = React.useCallback((initData = {}) => {
          if(!didInitState) {
            Object.assign(_pageData, {...initData})
            setDidInitState(true);
          }
        }, [setPageData, didInitState])

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
          _setUpdateSubComponentToken(Date.now())
        }

        const subComponents = React.useMemo(() => {
          return _subComponents
        }, [_updateSubComponentToken])

        const validateForm = React.useCallback(async (formName) => {
          const actionId = uuidv4();
          const promiseResult = new Promise((resolve) => {
            webJSChannel.once(actionId, (data) => {
              const { result } = JSON.parse(data);
              resolve(result);
            });
          });
          dispatchFormAction('$pagePath'+ formName, actionId, "validate");
          return promiseResult;
        }, [])

        const openDrawer = React.useCallback(() => {
          _openDrawer('$pagePath')
        }, [_openDrawer, context['$pagePath']])

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

        // Update current ThemeData from flutter to js side into \$themeData variable
        const _onUpdateThemeData = React.useCallback((themeDataAsJSON) => {
          
          if(!_.isString(themeDataAsJSON)) return

          try {
            const themeData = JSON.parse(themeDataAsJSON)
            _setThemeData(themeData)
          }
          catch(err){
            console.log(`Error: Input theme data is not JSON`)
            console.error("Input theme data is not JSON")
          }
        }, [])

        // export pages util function
        React.useEffect(() => {
          exportPageContext({
            validateForm,
            setPageData,
            getPageData,
            registerSubComponent,
            openDrawer,
            _onMediaQueryChanged,
            _onUpdateThemeData,
          })
          context['$pagePath'].exportPageContext = exportPageContext
        }, [
          setPageData, 
          getPageData, 
          registerSubComponent, 
          exportPageContext,
          validateForm,
          openDrawer,
          _onMediaQueryChanged,
          _onUpdateThemeData
        ])

        //==========================Start Page Code==========================================

        $clientCode

        //==========================End Page Code============================================

        React.useEffect(() => {
          if (isMounted()) {
            // init data for page
            setPageData({ _tLoaded: true })
          }
        }, [isMounted])

        React.useEffect(() => {
          logger.log(`Didmount $pagePath`)
          return () => {
            logger.log(`Unmounted $pagePath`)
            setContextData({
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
              let propFromParentContext = _.get(context, `$pagePath.\${value}`)
              
              result[key] = propFromParentContext != undefined ? propFromParentContext : value

              if(value && isValueBinding(value)) {
                const propsFromParentData = getBindingValue(getPageData(), value)

                /** 
                 * If the props not in parent data then we 
                 * will get from parent context 
                 */
                if(!propsFromParentData) {
                  propsFromParentContext = getBindingValue(_.get(context, '$pagePath'), value)
                }
                result[key] =  propsFromParentData ?? result[key]
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

  String getUnregisterComponentCode({
    required String parentPagePath,
    required String componentPath,
  }) {
    String unregisterComponentCode = """
      /** set timeout to wait for parent unmounted  */
      setTimeout(() => {
        const componentEl = document.getElementById("$componentPath")
        const parentEl = document.getElementById("$parentPagePath")
        if(parentEl) {
          parentEl.removeChild(componentEl);
          ReactDOM.unmountComponentAtNode(componentEl);
        }
      }, 200)
    """;
    return unregisterComponentCode;
  }

  String getUpdateJSThemeDataCode(ThemeData? themeData) {
    String updateJSThemeData = """_onUpdateThemeData('${jsonEncode(
      ThemeEncoder.encodeThemeData(themeData),
    )}')
    """;
    return updateJSThemeData;
  }
}
