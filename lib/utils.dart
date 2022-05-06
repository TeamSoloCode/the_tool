import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gato/gato.dart' as gato;
import 'package:get_it/get_it.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:webview_flutter/platform_interface.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  Map<String, String> _staticContent = {};

  UtilsManager() : super() {}

  Future<void> loadStaticContent() async {
    String vendorContent =
        await rootBundle.loadString('js-module/dist/vendors.js');
    String appContent = await rootBundle.loadString('js-module/dist/app.js');
    String fileContent =
        await rootBundle.loadString('js-module/dist/index.html');

    _staticContent = {
      "vendor": vendorContent,
      "app": appContent,
      "htmlContent": fileContent
    };
  }

  get staticContent => _staticContent;

  String bindingValueToString(Map<String, dynamic> contextData, String text) {
    var computedText = text;
    var regexPattern = RegExp(r"[^{{\}}]+(?=}})");

    regexPattern.allMatches(text).forEach((element) {
      var match = regexPattern.firstMatch(computedText);

      if (match != null) {
        var bindingData = gato.get(
              contextData,
              computedText.substring(match.start, match.end),
            ) ??
            "";

        computedText = computedText.replaceRange(
          match.start - 2,
          match.end + 2,
          bindingData.toString(),
        );
      }
    });

    return computedText;
  }

  Set<JavascriptChannel>? registerJavascriptChannel(
    BuildContext context,
    ContextStateProvider contextStateProvider,
  ) {
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
        Navigator.of(context).pushNamed(message.message);
      },
    );

    channels.addAll([message, updateState, navigator]);

    return channels;
  }
}
