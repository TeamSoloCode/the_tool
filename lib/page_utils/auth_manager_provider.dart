import 'package:flutter/foundation.dart';
import 'package:the_tool/utils.dart';

class AuthManagerProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final utils = getIt<UtilsManager>();

  final Map<String, bool> _authContext = const {};

  Map<String, bool> get authContext => _authContext;

  void updateAuthContext(Map<String, bool> authData) {
    _authContext.addAll(authData);
    notifyListeners();
  }
}
