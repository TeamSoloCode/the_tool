import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_tool/page_provider/auth_manager_provider.dart';
import 'package:the_tool/utils.dart';

class AuthGuard extends RouteGuard {
  String authKey;

  AuthGuard({
    required this.authKey,
    required String redirectTo,
  }) : super(
          redirectTo: redirectTo,
        );

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    var authContext = getIt<AuthManagerProvider>().authContext;
    return authContext[authKey] ?? false;
  }
}
