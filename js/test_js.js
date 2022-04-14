useStateInit({ abcd: "Init State", initState: Date.now() });

function onClickButton() {
  console.log("abcd onClickButton clicked");
}

function handleInterval() {
  console.log("abcd handleInterval", _state.abcd);
}

useStateEffect((state, prev) => {
  console.log("abcd useStateEffect init");
}, []);

useStateEffect(
  (state, prev) => {
    console.log("abcd useStateEffect abcd", state.abcd, prev);
  },
  ["abcd"]
);

useStateEffect(
  (state) => {
    console.log("abcd useStateEffect testData", state.testData);
  },
  ["testData"]
);
