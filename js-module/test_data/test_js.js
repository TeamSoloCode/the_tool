const [testState, setTestState] = React.useState("Init state");

const test = React.useMemo(() => {
  return "mlem mlem";
}, [testState]);

React.useEffect(() => {
  messageHandler.postMessage(`Test Effect ${testState}`);
}, [testState]);

React.useEffect(() => {
  messageHandler.postMessage(`Context data ${_contextData.abcd}`);
}, [_contextData]);

React.useEffect(() => {
  messageHandler.postMessage(`Context previous data ${_prevContextData?.abcd}`);
}, [_prevContextData]);

context.testFunction = () => {
  setTestState(`Updated react hook state ${Date.now()}`);
  context.setContextData({ test: Date.now() });
};
