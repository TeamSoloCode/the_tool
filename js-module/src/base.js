const context = { _data: {} };

const setContextData = (data, callback) => {
  const dataAsString = JSON.stringify(data);
  setState.postMessage(dataAsString);
  Object.assign({}, context._data, { data });
  context._updateContextData({ ...context._data, ...data });
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

function testForWeb(abcd) {
  console.log("abcd", abcd);
}

testForWeb();

context.setContextData = setContextData;
context.usePrevious = usePrevious;
context.testForWeb = testForWeb;
window.context = context;
