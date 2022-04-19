const [testState, setTestState] = React.useState("Init state");

const test = React.useMemo(() => {
  return "mlem mlem";
}, [testState]);

React.useEffect(() => {
  messageHandler.postMessage(`Test Effect ${testState}`);
}, [testState]);

context.testFunction = () => {
  setTestState(`Updated react hook state ${Date.now()}`);
};
