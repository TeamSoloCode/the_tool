function onClickButton() {
  console.log("abcd onClickButton clicked");
}

useStateEffect(
  (state) => {
    console.log("abcd useStateEffect abcd", state.abcd);
  },
  ["abcd"]
);

useStateEffect(
  (state) => {
    console.log("abcd useStateEffect testData", state.testData);
  },
  ["testData"]
);
