class TLogger {
  log(args) {
    if (context._platform === "mobile") {
      // window["messageHandler"]?.postMessage?.(args);
      console.log(args);
    } else {
      console.log(args);
    }
  }
}

const logger = new TLogger();
window.logger = logger;
