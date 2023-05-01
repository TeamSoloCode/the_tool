import 'dart:convert';

import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/utils.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaseInvokeJS {
  const BaseInvokeJS();

  String updateRouteAuthData(String action, String routeAuthAsJSON) {
    var authData = Map<String, bool>.from(jsonDecode(routeAuthAsJSON));
    var authContextProvider = getIt<AuthContextProvider>();
    switch (action) {
      case "set":
        authContextProvider.updateAuthContext(authData);
        break;
      case "clear":
        authContextProvider.clearAppAuthContext();
        break;
    }

    return jsonEncode(getIt<AuthContextProvider>().authContext);
  }

  void processNavigate(
    String route,
    Map<String, dynamic> data,
    Map<String, dynamic>? options,
  ) {
    if (options != null) {
      switch (options["action"]) {
        case "replacement_route":
          Modular.to.pushReplacementNamed(
            route,
            arguments: data,
          );
          break;

        case "pop":
          Modular.to.pop();
          break;

        case "pop_and_push":
          Modular.to.popAndPushNamed(
            route,
            arguments: data,
          );
          break;

        default:
          Modular.to.pushNamed(route, arguments: data);
          break;
      }
    }
  }
}
