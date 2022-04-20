import 'package:flutter/services.dart';

class UtilsManager {
  const UtilsManager();

  Future<String> _loadJSBundleIntoIndexHTML() async {
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

    return replacedContent;
  }

  Future<String> composeIndexHTML(String clientPageCode) async {
    String indexHTML = await _loadJSBundleIntoIndexHTML();

    return indexHTML.replaceAll(
      "// <app_code>",
      clientPageCode,
    );
  }
}
