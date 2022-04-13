const _state = {};
let _prevState = {};

const initState = (initState) => {
  Object.assign(_state, { ...initState });
};

const setState = (data) => {
  console.log("abcd", _state, data);
  _prevState = { ..._state };

  sendMessage("__set_state__", JSON.stringify({ ...data }));

  Object.assign(_state, { ...data });
  return _state;
};

const useEffect = (fn, deps = []) => {
  fn(_state, _prevState);
};
