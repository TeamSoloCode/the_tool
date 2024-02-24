import 'package:flutter/material.dart';
import 'package:the_tool/api/client_api.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:the_tool/twidget_props.dart';

class TComponent extends TWidget {
  TComponent(TWidgetProps twidget) : super(twidget);

  @override
  State<TComponent> createState() => _TComponentState();
}

class _TComponentState extends TStatefulWidget<TComponent> {
  LayoutProps? _pageLayout;
  String _componentId = "";
  Map<String, dynamic> _pageInfo = {};
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
      parentPagePath = widget.pagePath.substring(0, idSeperatorContext);
    }

    if (componentPath == parentPagePath) {
      throw Exception("Parent page path and component path cannot the same");
    }

    _componentId = "${componentPath}_${const Uuid().v4()}";

    _props = widget.utils.computeWidgetProps(
      widget.widgetProps,
      widget.getContexData(),
    );

    _pageLayout = await widget.utils.evalJS?.registerSubComponent(
      componentPath: _componentId,
      parentPagePath: widget.pagePath,
      componentPropsAsJSON: _props?.componentProps ?? {},
      computedComponentPropsAsJSON: _props?.computedComponentProps ?? {},
    );

    getIt<ContextStateProvider>().addPageComponents(
      pagePath: _componentId,
      components: _pageLayout!.components!,
    );

    // TODO: waiting for the sub component successfully registered
    // while (getIt<ContextStateProvider>().contextData[_componentId] == null) {
    //   await Future.delayed(const Duration(milliseconds: 16));
    // }

    return;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildWidget(BuildContext context) {
    // var contextData =
    //     getIt<ContextStateProvider>().contextData[widget.pagePath] ??
    //         emptyMapStringDynamic;

    snapshot = FutureBuilder(
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

    return snapshot;
  }
}
