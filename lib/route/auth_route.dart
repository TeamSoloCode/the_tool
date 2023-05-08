import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_tool/utils.dart';

class AuthGuard extends RouteGuard {
  String authFunction;

  AuthGuard({
    required String redirectTo,
    required this.authFunction,
  }) : super(
          redirectTo: redirectTo,
        );

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    var isAuthorized = await getIt<UtilsManager>()
        .evalJS
        ?.executeAsyncJS(authFunction, "core");

    return isAuthorized ?? false;
  }
}
