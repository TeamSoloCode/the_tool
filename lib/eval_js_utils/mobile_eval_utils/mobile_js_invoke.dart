library mobile_js_invoke;

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/storage_utils.dart';
import 'package:the_tool/utils.dart';

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

  webViewController?.addJavaScriptHandler(
    handlerName: "set_cookies",
    callback: (args) {
      String key = args[0];
      dynamic value = args[1];
      getIt<StorageManager>().setCookies(key, value);
    },
  );

  webViewController?.addJavaScriptHandler(
    handlerName: "get_cookies",
    callback: (args) {
      String key = args[0];
      return getIt<StorageManager>().getCookies(key);
    },
  );

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
