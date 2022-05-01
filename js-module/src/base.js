export const context = { _data: {}, _prevData: {}, _platform: "mobile" };

const setContextData = (data, callback = () => {}) => {
  const nextData = Object.assign({}, context._data, data);
  const dataAsString = JSON.stringify(nextData);
  if (context._platform == "mobile") {
    setState.postMessage(dataAsString);
  } else if (context._platform == "web") {
    setState(dataAsString, callback);
  }

  context._updateContextData(nextData);
};

const navigateTo = (routeName) => {
  if (context._platform == "mobile") {
    navigate.postMessage(routeName);
  } else if (context._platform == "web") {
    navigate(routeName);
  }

}

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

Object.assign(context, { setContextData, usePrevious, setPlatform, navigateTo });
window.context = context;
