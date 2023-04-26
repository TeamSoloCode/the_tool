import 'dart:convert';

import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/utils.dart';

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
}
