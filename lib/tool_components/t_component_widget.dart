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
  final String pagePath;
  T_Component({
    Key? key,
    required executeJS,
    required widgetProps,
    required this.pagePath,
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
  String _componentId = "";
  Map<String, dynamic> _pageInfo = {};
  bool isReady = false;

  @override
  void dispose() {
    super.dispose();
    _utils.evalJS?.unregisterSubComponent(
      parentPagePath: widget.pagePath,
      componentPath: _componentId,
    );
  }

  Future<void> _loadComponentInfo(String componentPath) async {
    APIClientManager apiClient = getIt<APIClientManager>();
    _pageInfo = await apiClient.getClientPageInfo(componentPath);

    var layout = _pageInfo["layout"];
    _pageLayout = LayoutProps.fromJson(layout);

    _componentId = "${componentPath}_${const Uuid().v4()}";

    await _utils.evalJS?.registerSubComponent(
      componentCode: _pageInfo["code"],
      componentPath: _componentId,
      parentPagePath: widget.pagePath,
      componentPropsAsJSON: widget.widgetProps.componentProps ?? {},
    );

    Future.delayed(Duration.zero, () async {
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var path = widget.widgetProps.path;

    if (path == null || !isReady) {
      _loadComponentInfo(widget.widgetProps.path!);
      return const SizedBox.shrink();
    }

    Map<String, dynamic> componentData =
        context.select((ContextStateProvider value) {
      Map<String, dynamic> data =
          value.contextData[_componentId] ?? Map<String, dynamic>.from({});
      return data;
    });

    return T_Widgets(
      key: Key(_componentId),
      layout: _pageLayout ?? const LayoutProps(),
      pagePath: _componentId,
      contextData: componentData,
    );
  }
}
