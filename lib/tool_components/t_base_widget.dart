import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/base_widget_container.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

class T_BaseWidget extends StatefulWidget {
  const T_BaseWidget({Key? key}) : super(key: key);

  @override
  State<T_BaseWidget> createState() => _T_BaseWidgetState();
}

class _T_BaseWidgetState extends State<T_BaseWidget> {
  Map<String, dynamic>? _config = {};

  @override
  void initState() {
    (() async {
      APIClientManager apiClient = getIt<APIClientManager>();
      Map<String, dynamic> config = await apiClient.getClientConfig();
      setState(() {
        _config = config;
      });
    })();

    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: _computeRoutes(),
        home: Stack(
          children: [
            T_BaseWidget_Container(
              pagePath: "test_page",
            ),
          ],
        ));
  }
}
