import 'package:flutter/foundation.dart';
import 'package:the_tool/utils.dart';

class AuthContextProvider with ChangeNotifier {
  final utils = getIt<UtilsManager>();

  var refreshToken = DateTime.now().microsecondsSinceEpoch;

  late Map<String, bool> _authContext;

  AuthContextProvider() : super() {
    _authContext = {};
  }

  Map<String, bool> get authContext => _authContext;

  void updateAuthContext(Map<String, bool> authData) {
    _authContext.addAll(authData);
    refreshToken = DateTime.now().microsecondsSinceEpoch;
    notifyListeners();
  }

  void clearAppAuthContext() {
    _authContext.clear();
    refreshToken = DateTime.now().microsecondsSinceEpoch;
    notifyListeners();
  }
}
