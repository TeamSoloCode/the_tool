import 'package:flutter/material.dart';
import 'package:modular_core/modular_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/route/auth_route.dart';
import 'package:the_tool/static_pages/not_found.page.dart';
import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/t_widget_interface/client_config/app_route_config/app_route_config.dart';

class AppModule extends Module {
  Map<String, Widget Function(BuildContext, ModularArguments)>? _routes;
  Map<String, List<AuthGuard>>? _routeGuardMap;

  AppModule(ClientConfig config) : super() {
    _routes = {};
    _routeGuardMap = {};

    _computeRoutesAndAuthGuards();
  }

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes {
    var clientConfig = getIt<ContextStateProvider>().appConfig;

    var appRoutes = _routes!.entries.map((route) {
      return ChildRoute(
        route.key,
        child: (context, ModularArguments args) {
          return route.value(context, args);
        },
        guards: _routeGuardMap![route.key] ?? [],
      );
    }).toList();

    appRoutes.add(
      WildcardRoute(
        child: (context, args) {
          var notFoundPagePath = clientConfig?.notFoundPagePath;
          if (notFoundPagePath == null) {
            return const DefaultNotFoundPage();
          }

          return TPage(
            pagePath: notFoundPagePath,
            modularArguments: args,
          );
        },
      ),
    );

    return appRoutes;
  }

  String _getInitialPage(ClientConfig? clientConfig) {
    String? initialPage = clientConfig?.initialPage;

    if (initialPage == null || initialPage == "") {
      throw Exception("Missing initial page path in config");
    }

    return initialPage;
  }

  void _computeRoutesAndAuthGuards() {
    var appConfig = getIt<ContextStateProvider>().appConfig;

    var routeConfig = appConfig?.routes;
    if (routeConfig == null) return;

    List<AppRouteConfig> routesConfig = routeConfig;
    Map<String, Widget Function(BuildContext, ModularArguments)> routes = {};

    var initialPath = _getInitialPage(appConfig);
    Modular.setInitialRoute("/$initialPath");

    for (var routeConfig in routesConfig) {
      if (routeConfig.path == null) {
        throw Exception("path in routes config cannot be null");
      }

      String pagePath = routeConfig.path!;
      String routePath = "/${routeConfig.route ?? pagePath}";

      if (routeConfig.guards != null) {
        _routeGuardMap!.addAll({
          routePath: routeConfig.guards!.map((routeGuardConfig) {
            if (routeGuardConfig.authFunction == null ||
                routeGuardConfig.redirectTo == null) {
              throw Exception(
                "Route Guards: \"authFunction\" and \"redirectTo\" properties must be specified in route guard",
              );
            }

            return AuthGuard(
              redirectTo: routeGuardConfig.redirectTo!,
              authFunction: routeGuardConfig.authFunction!,
            );
          }).toList()
        });
      }

      _routes!.addAll({
        routePath: (context, args) => TPage(
              pagePath: pagePath,
              modularArguments: args,
            ),
      });
    }
  }
}
