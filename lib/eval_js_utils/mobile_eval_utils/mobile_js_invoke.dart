library mobile_js_invoke;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/permission_manager.dart';
import 'package:the_tool/page_utils/storage_manager.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
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
  InAppWebViewController? webViewController,
) {
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
      Map<String, dynamic>? pageArguments = navigateData["pageArguments"];
      Map<String, dynamic>? options = navigateData["options"];

      if (options != null && options["replacementRoute"] == true) {
        Navigator.of(context).pushReplacementNamed(
          "/$routeName",
          arguments: pageArguments,
        );
        return;
      }

      Navigator.of(context).pushNamed("/$routeName", arguments: pageArguments);
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

  webViewController?.addJavaScriptHandler(
    handlerName: "toggle_change_theme",
    callback: (args) {
      context.read<ThemeProvider>().toogleChangeThemeMode(null);
    },
  );

  webViewController?.addJavaScriptHandler(
    handlerName: "dispatch_form_action",
    callback: (args) async {
      getIt<UtilsManager>().emitter.emit(args[0], context, args[1]);
    },
  );

  webViewController?.addJavaScriptHandler(
    handlerName: "fetch_data",
    callback: (args) async {
      var options = json.decode(args[1]);
      RequestOptions requestOptions = RequestOptions(
        path: args[0],
        method: options["method"],
        data: options["body"],
      );
      return await getIt<APIClientManager>().fetchData(
        requestOptions: requestOptions,
      );
    },
  );

  webViewController?.addJavaScriptHandler(
    handlerName: "permission_event",
    callback: (args) async {
      var permissionManager = getIt<PermissionManager>();
      PermissionStatus? permissionStatus;
      switch (args[0]) {
        case "request":
          permissionStatus = await permissionManager.requestPermission(args[1]);
          break;
        case "status":
          permissionStatus =
              await permissionManager.getPermissionStatus(args[1]);
          break;
        case "open_app_settings":
          return await permissionManager.requestOpenAppSettings();
      }
      return permissionManager.permissionStatusToMap(permissionStatus);
    },
  );
}

void main() {}
