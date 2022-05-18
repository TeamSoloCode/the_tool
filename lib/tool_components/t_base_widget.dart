import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/tool_components/base_widget_container.dart';
import 'package:the_tool/utils.dart';
import 'package:gato/gato.dart' as gato;

class T_BaseWidget extends StatefulWidget {
  const T_BaseWidget({Key? key}) : super(key: key);

  @override
  State<T_BaseWidget> createState() => _T_BaseWidgetState();
}

class _T_BaseWidgetState extends State<T_BaseWidget> {
  Map<String, dynamic>? _config = {};

  @override
  void initState() {
    print("initState");
    (() async {
      APIClientManager apiClient = getIt<APIClientManager>();
      Map<String, dynamic> config = await apiClient.getClientConfig();
      setState(() {
        _config = config;
      });
    })();

    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  Map<String, Widget Function(BuildContext)> _computeRoutes() {
    if (_config == null || gato.get(_config, "routes") == null) return {};

    Map<String, Widget Function(BuildContext)> routes = {};
    List<Map<String, dynamic>> routesConfig = gato.get(_config, "routes");

    routesConfig.forEach((routeConfig) {
      String path = routeConfig['path'];
      routes.addAll({
        path: (context) => T_BaseWidget_Container(pagePath: path),
      });
    });

    return routes;
  }

  final Future<bool> _isReadyToRun = Future<bool>.microtask(() async {
    if (!kIsWeb) {
      await getIt<UtilsManager>().loadStaticContent();
    }

    return true;
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _computeRoutes(),
      home: FutureBuilder<bool>(
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Stack(
              children: [
                T_BaseWidget_Container(
                  pagePath: "test_page",
                ),
              ],
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        },
        future: _isReadyToRun,
      ),
    );
  }
}
