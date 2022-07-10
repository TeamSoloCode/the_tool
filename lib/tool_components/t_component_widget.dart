import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';

class T_Component extends T_Widget {
  final String parentPagePath;
  T_Component({
    Key? key,
    required executeJS,
    required widgetProps,
    required this.parentPagePath,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  @override
  State<T_Component> createState() => _T_ComponentState();
}

class _T_ComponentState extends State<T_Component> {
  LayoutProps? _pageLayout;
  final UtilsManager _utils = getIt<UtilsManager>();
  bool _loaded = false;
  String _componentId = "";

  @override
  void dispose() {
    _utils.evalJS?.unregisterSubComponent(
      parentPagePath: widget.parentPagePath,
      componentPath: _componentId,
    );
    super.dispose();
  }

  Future<void> _loadComponentInfo(String componentPath) async {
    APIClientManager apiClient = getIt<APIClientManager>();
    Map<String, dynamic> pageInfo =
        await apiClient.getClientPageInfo(componentPath);
    var layout = pageInfo["layout"];
    _pageLayout = LayoutProps.fromJson(layout);

    _componentId = "${componentPath}_${const Uuid().v4()}";

    await _utils.evalJS?.registerSubComponent(
      componentCode: pageInfo["code"],
      componentPath: _componentId,
      parentPagePath: widget.parentPagePath,
      componentPropsAsJSON: json.encode(_pageLayout?.componentProps),
    );
  }

  @override
  Widget build(BuildContext context) {
    var path = widget.widgetProps.path;

    if (path == null) {
      return const SizedBox.shrink();
    }

    return FutureBuilder(
      builder: (context, snapshot) {
        const loadingPage = Text("Loading...");

        if (snapshot.data == true) {
          var componentData = context.select((ContextStateProvider value) {
            var data = value.contextData[_componentId] ??
                Map<String, dynamic>.from({});
            return data;
          });

          var componentProps = widget.widgetProps.componentProps;

          print(
            "$_componentId: $componentProps $componentData",
          );

          return Container(
            constraints: BoxConstraints(maxHeight: 200),
            child: T_Widgets(
              layout: _pageLayout ?? const LayoutProps(),
              pagePath: _componentId,
              contextData: componentData,
            ),
          );
        }
        return loadingPage;
      },
      future: _isReadyToRun(path),
    );
  }

  Future<bool> _isReadyToRun(String pagePath) async {
    return Future<bool>.microtask(() async {
      if (!_loaded) {
        await _loadComponentInfo(pagePath);
      }
      _loaded = true;
      return true;
    });
  }
}
