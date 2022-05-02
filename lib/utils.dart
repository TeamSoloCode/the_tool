import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:webview_flutter/platform_interface.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super() {}

  String bindingValueToString(Map<String, dynamic> contextData, String text) {
    if (text.contains("@")) {
      String result = text.split(" ").map((element) {
        if (element.startsWith("@")) {
          String dataName = element.substring(1);
          return contextData[dataName];
        }

        return element;
      }).join(" ");
      return result;
    }

    return text;
  }

  Set<JavascriptChannel>? registerJavascriptChannel(
      BuildContext context, ContextStateProvider contextStateProvider) {
    Set<JavascriptChannel> channels = Set<JavascriptChannel>();
    JavascriptChannel message = JavascriptChannel(
      name: 'messageHandler',
      onMessageReceived: (JavascriptMessage message) {
        print(
          "\"${message.message}\"",
        );
      },
    );

    JavascriptChannel updateState = JavascriptChannel(
      name: 'setState',
      onMessageReceived: (JavascriptMessage message) {
        Map<String, dynamic> data = json.decode(message.message);
        contextStateProvider.updateContextData(data);
      },
    );

    JavascriptChannel navigator = JavascriptChannel(
      name: 'navigate',
      onMessageReceived: (JavascriptMessage message) {
        log(message.message);
        // contextStateProvider.updateContextData(data);
        // Navigator.of(context).push(RouteName.homePage);
      },
    );

    channels.addAll([message, updateState, navigator]);

    return channels;
  }
}
