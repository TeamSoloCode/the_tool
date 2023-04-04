import "regenerator-runtime/runtime";
import _ from "lodash";
import * as _React from "react";
import _ReactDOM from "react-dom";
import * as _moment from "moment";
import * as _hooks from "usehooks-ts";

window.React = _React;
window.ReactDOM = _ReactDOM;
window._ = _;
window.moment = _moment;
window.hooks = _hooks;

import "./logger";
import "./base";

import App from "./app";

_ReactDOM.render(<App />, document.getElementById("app"));
