import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:the_tool/pageUtils/context_state_provider.dart';
import 'package:webview_flutter/platform_interface.dart';

GetIt getIt = GetIt.instance;

class UtilsManager {
  const UtilsManager();

  Future<String> composeIndexHTML(String clientPageCode) async {
    String vendorContent =
        await rootBundle.loadString('js-module/dist/vendors.js');
    String appContent = await rootBundle.loadString('js-module/dist/app.js');
    String fileContent =
        await rootBundle.loadString('js-module/dist/index.html');

    String replacedContent = fileContent.replaceAll(
      "// <vendor_code>",
      vendorContent,
    );

    replacedContent = replacedContent.replaceAll(
      "// <app_code>",
      appContent,
    );

    replacedContent = replacedContent.replaceAll(
      "// <client_code>",
      clientPageCode,
    );

    return replacedContent;
  }

  Set<JavascriptChannel>? registerJavascriptChannel(
      void Function(void Function() fn) setState,
      Map<String, dynamic> contextData,
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
        setState(
          () {
            contextData.addAll(data);
            contextStateProvider.updateContextData(data);
          },
        );
      },
    );

    channels.addAll([message, updateState]);
    return channels;
  }
}
