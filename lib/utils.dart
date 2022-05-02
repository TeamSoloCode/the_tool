import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:webview_flutter/platform_interface.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super() {}

  Set<JavascriptChannel>? registerJavascriptChannel(
      ContextStateProvider contextStateProvider) {
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

    channels.addAll([message, updateState]);
    return channels;
  }
}
