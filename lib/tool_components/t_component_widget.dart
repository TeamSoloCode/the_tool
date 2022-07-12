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
  String _componentId = "";
  Map<String, dynamic> _pageInfo = {};
  bool isReady = false;

  @override
  void initState() {
    if (widget.widgetProps.path != null) {
      _loadComponentInfo(widget.widgetProps.path!);
    }

    super.initState();
  }

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
    _pageInfo = await apiClient.getClientPageInfo(componentPath);

    var layout = _pageInfo["layout"];
    _pageLayout = LayoutProps.fromJson(layout);

    _componentId = "${componentPath}_${Timeline.now}";

    await _utils.evalJS?.registerSubComponent(
      componentCode: _pageInfo["code"],
      componentPath: _componentId,
      parentPagePath: widget.parentPagePath,
      componentPropsAsJSON: widget.widgetProps.componentProps ?? {},
    );

    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var path = widget.widgetProps.path;

    if (path == null || !isReady) {
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
