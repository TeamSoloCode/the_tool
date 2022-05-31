library mobile_js_invoke;

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';

external JavaScriptHandler updateState;

class JavaScriptHandler {
  late String handlerName;
  late dynamic Function(List<dynamic>) callback;

  JavaScriptHandler({
    required String handlerName,
    required dynamic Function(List<dynamic>) callback,
  });
}

void registerJavascriptHandler(
    BuildContext context,
    ContextStateProvider contextStateProvider,
    InAppWebViewController? webViewController) {
  // Set<JavascriptChannel> channels = Set<JavascriptChannel>();
  // JavascriptChannel message = JavascriptChannel(
  //   name: 'messageHandler',
  //   onMessageReceived: (JavascriptMessage message) {
  //     print(
  //       "\"${message.message}\"",
  //     );
  //   },
  // );

  webViewController?.addJavaScriptHandler(
    handlerName: "setState",
    callback: (args) {
      contextStateProvider.updateContextData(args[0]);
    },
  );

  webViewController?.addJavaScriptHandler(
    handlerName: "navigate",
    callback: (args) {
      Map<String, dynamic> navigateData = args[0];
      String routeName = navigateData["pagePath"];
      Map<String, dynamic> pageArguments = navigateData["pageArguments"];

      Navigator.of(context).pushNamed(routeName, arguments: pageArguments);
    },
  );

  // JavascriptChannel navigator = JavascriptChannel(
  //   name: 'navigate',
  //   onMessageReceived: (JavascriptMessage message) {
  //     Map<String, dynamic> navigateData = json.decode(message.message);
  //     String routeName = navigateData["pagePath"];
  //     Map<String, dynamic> pageArguments = navigateData["pageArguments"];

  //     Navigator.of(context).pushNamed(routeName, arguments: pageArguments);
  //   },
  // );

  // JavascriptChannel setCookies = JavascriptChannel(
  //   name: 'set_cookies',
  //   onMessageReceived: (JavascriptMessage message) {
  //     Map<String, dynamic> cookieInfo = json.decode(message.message);
  //     String key = cookieInfo["key"];
  //     dynamic value = cookieInfo["value"];
  //     getIt<StorageManager>().setCookies(key, value);
  //   },
  // );

  // JavascriptChannel getCookies = JavascriptChannel(
  //   name: 'get_cookies',
  //   onMessageReceived: (JavascriptMessage message) {
  //     String key = message.message;
  //     print("abcd ${getIt<StorageManager>().getCookies(key)}");
  //     return getIt<StorageManager>().getCookies(key);
  //   },
  // );
}

void main() {}
