import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/utils.dart';

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
              child: (context, args) => entry.value(context),
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

  Map<String, Widget Function(BuildContext)> _computeRoutes() {
    var config = getIt<ContextStateProvider>().appConfig;
    var routeConfig = config?.routes;
    if (routeConfig == null) return {};

    List<Map<String, dynamic>> routesConfig = routeConfig;
    Map<String, Widget Function(BuildContext)> routes = {};

    var initialPath = _getInitialPage(config);

    for (var routeConfig in routesConfig) {
      String routePath = routeConfig['path'];
      String appRoutePath = "/$routePath";

      if (initialPath == routePath) {
        appRoutePath = "/";
      }

      routes.addAll({
        appRoutePath: (context) => T_Page(pagePath: routePath),
      });
    }

    return routes;
  }
}
