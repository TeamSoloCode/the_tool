import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';

class T_Component extends TWidget {
  T_Component({
    Key? key,
    required widgetProps,
    required pagePath,
    childData = const {},
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          childData: childData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_Component> createState() => _T_ComponentState();
}

class _T_ComponentState extends State<T_Component>
    with AutomaticKeepAliveClientMixin {
  LayoutProps? _pageLayout;
  String _componentId = "";
  Map<String, dynamic> _pageInfo = {};
  bool _isReady = false;
  LayoutProps? _props;
  var emptyMapStringDynamic = UtilsManager.emptyMapStringDynamic;

  @override
  void initState() {
    super.initState();
    if (widget.widgetProps.path != null) {
      _loadComponentInfo(widget.widgetProps.path!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.utils.evalJS?.unregisterSubComponent(
      parentPagePath: widget.pagePath,
      componentPath: _componentId,
    );
  }

  Future<void> _loadComponentInfo(String componentPath) async {
    var parentPagePath = widget.pagePath.substring(
      widget.pagePath.lastIndexOf("_"),
    );

    if (componentPath == parentPagePath) {
      throw Exception("Parent page path and component path cannot the same");
    }

    var contextStateProvider = getIt<ContextStateProvider>();
    APIClientManager apiClient = getIt<APIClientManager>();
    _pageInfo = await apiClient.getClientPageInfo(componentPath);

    var layout = _pageInfo["layout"];
    _pageLayout = LayoutProps.fromJson(layout);

    _componentId = "${componentPath}_${const Uuid().v4()}";

    if (_pageLayout?.components != null) {
      contextStateProvider.addPageComponents(
        pagePath: _componentId,
        components: _pageLayout!.components!,
      );
    }

    var contextData = contextStateProvider.contextData[widget.pagePath] ??
        emptyMapStringDynamic;

    _props = widget.utils.computeWidgetProps(
      widget.widgetProps,
      widget.childData.isEmpty
          ? contextData
          : Map<String, dynamic>.from(widget.childData),
    );

    await widget.utils.evalJS?.registerSubComponent(
      componentCode: _pageInfo["code"],
      componentPath: _componentId,
      parentPagePath: widget.pagePath,
      componentPropsAsJSON: _props?.componentProps ?? {},
      computedComponentPropsAsJSON: _props?.computedComponentProps ?? {},
    );

    Future.delayed(Duration.zero, () async {
      setState(() {
        _isReady = true;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  bool didBuild = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var path = _props?.path;

    if (path == null || !_isReady) {
      return const SizedBox.shrink();
    }

    if (didBuild) {
      return widget.snapshot;
    }

    // var contextData =
    //     getIt<ContextStateProvider>().contextData[widget.pagePath] ??
    //         emptyMapStringDynamic;

    widget.snapshot = TWidgets(
      key: Key(_componentId),
      layout: _pageLayout ?? const LayoutProps(),
      pagePath: _componentId,
      childData: widget.childData,
    );
    didBuild = true;
    return widget.snapshot;
  }
}
