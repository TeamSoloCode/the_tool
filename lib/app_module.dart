import 'package:flutter/material.dart';
import 'package:modular_core/modular_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/t_widget_interface/client_config/app_route_config/app_route_config.dart';

class AppModule extends Module {
  AppModule(ClientConfig config) : super();

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes {
    final routeMap = _computeRoutes();

    return routeMap.entries
        .map((entry) => ChildRoute(
              entry.key,
              child: (context, ModularArguments args) {
                return entry.value(context, args);
              },
            ))
        .toList();
  }

  String _getInitialPage(ClientConfig? clientConfig) {
    String? initialPage = clientConfig?.initialPage;

    if (initialPage == null || initialPage == "") {
      throw Exception("Missing initial page path in config");
    }

    return initialPage;
  }

  Map<String, Widget Function(BuildContext, ModularArguments)>
      _computeRoutes() {
    var config = getIt<ContextStateProvider>().appConfig;
    var routeConfig = config?.routes;
    if (routeConfig == null) return {};

    List<AppRouteConfig> routesConfig = routeConfig;
    Map<String, Widget Function(BuildContext, ModularArguments)> routes = {};

    var initialPath = _getInitialPage(config);
    Modular.setInitialRoute("/$initialPath");

    for (var routeConfig in routesConfig) {
      if (routeConfig.path == null) {
        throw Exception("path in routes config cannot be null");
      }

      String pagePath = routeConfig.path!;
      String route = "/${routeConfig.route ?? pagePath}";

      routes.addAll({
        route: (context, args) => TPage(
              pagePath: pagePath,
              modularArguments: args,
            ),
      });
    }

    return routes;
  }
}
