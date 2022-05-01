class Logger {
  platform = "mobile";
  constructor() {
    this.platform = context._platform;
  }

  log(args) {
    if (this.platform == "mobile") {
      messageHandler.postMessage(args);
    } else {
      console.log(args);
    }
  }
}

const logger = new Logger();
window.logger = logger;
