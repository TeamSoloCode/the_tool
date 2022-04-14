console.log("abcd --------------------------------------------------", Date.now());

const createInterval = (fnName, duration, id) => {
  sendMessage("__set_interval__", JSON.stringify({ fnName, duration, id }));
};

const useStateInit = (initState) => {
  if (!_.isEmpty(_initState)) return;
  Object.assign(_state, { ...initState });
  Object.assign(_initState, { ...initState });
  Object.assign(_prevState, { ...initState });
  sendMessage("__init_state__", JSON.stringify({ ...initState }));
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
  const checks = deps.map((dep) => {
    return _.isEqual(_.get(_state, dep, undefined), _.get(_prevState, dep, undefined));
  });

  if (!checks.includes(false)) {
    if (!_didMount && deps.length == 0) {
      fn(_state, _prevState);
    }
    return;
  }

  if (_.isEqual(_state, _initState)) {
    return;
  }

  fn(_state, _prevState);
};
