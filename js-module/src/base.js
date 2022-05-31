import _ from "lodash";

const _initContext = { _data: {}, _prevData: {}, _platform: "mobile" };
export const context = _initContext;

const setContextData = (data, callback = () => {}) => {
  const nextData = Object.assign({}, context._data, data);
  const dataAsString = JSON.stringify(nextData);
  if (context._platform == "mobile") {
    window.flutter_inappwebview.callHandler("setState", nextData);
  } else if (context._platform == "web") {
    setState(dataAsString, callback);
  }

  context._updateContextData(nextData);
};

const navigateTo = (pagePath, pageArguments = {}) => {
  const navigateData = { pagePath, pageArguments };
  context[pagePath] = context[pagePath] || {};
  context[pagePath]._pageArguments = pageArguments;

  if (context._platform == "mobile") {
    window.flutter_inappwebview.callHandler("navigate", navigateData);
  } else if (context._platform == "web") {
    navigate(pagePath, JSON.stringify(pageArguments));
  }
};

function usePrevious(value) {
  // The ref object is a generic container whose current property is mutable ...
  // ... and can hold any value, similar to an instance property on a class
  const ref = React.useRef();
  // Store current value in ref
  React.useEffect(() => {
    ref.current = value;
  }, [value]); // Only re-run if value changes
  // Return previous value (happens before update in useEffect above)
  return ref.current;
}

const setPlatform = (platform) => {
  Object.assign(context, { _platform: platform });
};

const isFunctionExistsOnContext = (functionName, pagePath) => {
  if (_.get(context, `${pagePath}.${functionName}`)) {
    return 1;
  }
  return 0;
};

const setCookies = (key, value) => {
  switch (context._platform) {
    case "web":
      break;

    case "mobile":
      window.flutter_inappwebview.callHandler("set_cookies", key, value);
      break;
  }
};

const getCookies = (key, defaultvalue) => {
  switch (context._platform) {
    case "web":
      break;

    case "mobile":
      const cookieData = window.flutter_inappwebview.callHandler(
        "get_cookies",
        key
      );
      if (cookieData) return cookieData;
      return defaultvalue;
  }
};

Object.assign(window, {
  setContextData,
  usePrevious,
  setPlatform,
  navigateTo,
  isFunctionExistsOnContext,
  setCookies,
  getCookies,
  context,
});
