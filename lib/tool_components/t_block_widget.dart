import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/page_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_Block extends T_Widget {
  T_Block({
    Key? key,
    required executeJS,
    required widgetProps,
    required contextData,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          executeJS: executeJS,
          contextData: contextData,
        );

  @override
  State<T_Block> createState() => _T_BlockState();
}

class _T_BlockState extends State<T_Block> {
  LayoutProps? _pageLayout;
  final UtilsManager _utils = getIt<UtilsManager>();

  Future<void> _loadPageInfo(String pagePath) async {
    APIClientManager apiClient = getIt<APIClientManager>();
    Map<String, dynamic> pageInfo = await apiClient.getClientPageInfo(pagePath);

    // _utils.evalJS?.executePageCode(
    //   pageInfo["code"],
    //   pagePath,
    // );
    var layout = pageInfo["layout"];

    _pageLayout = LayoutProps.fromJson(layout);
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
          return T_Widgets(
            layout: _pageLayout ?? const LayoutProps(),
            pagePath: path,
            contextData: widget.contextData,
          );
        }
        return loadingPage;
      },
      future: _isReadyToRun(path),
    );
  }

  Future<bool> _isReadyToRun(String pagePath) async {
    return Future<bool>.microtask(() async {
      await _loadPageInfo(pagePath);
      return true;
    });
  }
}
