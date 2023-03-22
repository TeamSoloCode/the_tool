import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:the_tool/twidget_props.dart';

class T_Component extends TWidget {
  T_Component(TWidgetProps twidget) : super(twidget);

  @override
  State<T_Component> createState() => _T_ComponentState();
}

class _T_ComponentState extends TStatefulWidget<T_Component> {
  LayoutProps? _pageLayout;
  String _componentId = "";
  Map<String, dynamic> _pageInfo = {};
  bool _isReady = false;
  LayoutProps? _props;
  late Future<void> _loadClientComponent;
  var emptyMapStringDynamic = UtilsManager.emptyMapStringDynamic;

  @override
  void initState() {
    if (widget.widgetProps.path != null) {
      _loadClientComponent = _loadComponentInfo(widget.widgetProps.path!);
    }
    super.initState();
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
    var idSeperatorContext = widget.pagePath.lastIndexOf("_");
    var parentPagePath = widget.pagePath;
    if (idSeperatorContext > -1) {
      parentPagePath = widget.pagePath.substring(idSeperatorContext);
    }

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

    _props = widget.utils.computeWidgetProps(
      widget.widgetProps,
      widget.getContexData(),
    );

    await widget.utils.evalJS?.registerSubComponent(
      componentCode: _pageInfo["code"],
      componentPath: _componentId,
      parentPagePath: widget.pagePath,
      componentPropsAsJSON: _props?.componentProps ?? {},
      computedComponentPropsAsJSON: _props?.computedComponentProps ?? {},
    );

    await Future.delayed(const Duration(milliseconds: 10));

    return;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildWidget(BuildContext context) {
    // var contextData =
    //     getIt<ContextStateProvider>().contextData[widget.pagePath] ??
    //         emptyMapStringDynamic;

    return FutureBuilder(
      // key: ValueKey(_pageId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Offstage();
        }
        return TWidgets(
          key: Key(_componentId),
          layout: _pageLayout ?? const LayoutProps(),
          pagePath: _componentId,
          childData: widget.childData,
        );
      },
      future: _loadClientComponent,
    );
  }
}
