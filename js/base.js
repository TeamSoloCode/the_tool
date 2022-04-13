console.log("abcd --------------------------------------------------");

const initState = (initState) => {
  Object.assign(_state, { ...initState });
};

const setState = (data) => {
  console.log("abcd prev state", _state);
  _prevState = { ..._state };

  sendMessage("__set_state__", JSON.stringify({ ...data }));

  Object.assign(_state, { ...data });

  console.log("abcd next state", _state);
  return _state;
};

const useStateEffect = (fn, deps = []) => {
  let changed = false;

  const checks = deps.map((dep) => {
    return _.isEqual(_.get(_state, dep, undefined), _.get(_prevState, dep, undefined));
  });

  changed = checks.includes(false);

  if (changed) {
    fn(_state, _prevState);
  }
};
