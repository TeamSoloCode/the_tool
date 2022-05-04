import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:gato/gato.dart' as gato;
import 'package:get_it/get_it.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:webview_flutter/platform_interface.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  UtilsManager() : super() {}

  String bindingValueToString(Map<String, dynamic> contextData, String text) {
    var computedText = text;
    var regexPattern = RegExp(r"[^{\}]+(?=})");

    regexPattern.allMatches(text).forEach((element) {
      var match = regexPattern.firstMatch(computedText);

      if (match != null) {
        var bindingData = gato.get(
              contextData,
              computedText.substring(match.start, match.end),
            ) ??
            "";

        computedText = computedText.replaceRange(
          match.start - 1,
          match.end + 1,
          bindingData.toString(),
        );
      }
    });

    return computedText;
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
