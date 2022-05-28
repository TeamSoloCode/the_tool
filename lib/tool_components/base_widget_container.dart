import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:the_tool/eval_js_utils/mobile_eval_utils/mobile_eval_js.dart'
    if (dart.library.js) 'package:the_tool/eval_js_utils/web_eval_utils/web_eval_js.dart';

class T_BaseWidget_Container extends StatefulWidget {
  String pagePath;
  T_BaseWidget_Container({Key? key, required this.pagePath}) : super(key: key);

  @override
  State<T_BaseWidget_Container> createState() => _T_BaseWidget_Container();
}

class _T_BaseWidget_Container extends State<T_BaseWidget_Container> {
  Map<String, dynamic> _prevPageState = {};
  Map<String, dynamic> _initPageState = {};
  Map<String, dynamic> _pageLayout = {};

  late UtilsManager utils;

  @override
  void initState() {
    utils = getIt<UtilsManager>();
    (() async {
      APIClientManager apiClient = getIt<APIClientManager>();
      Map<String, dynamic> pageInfo =
          await apiClient.getClientPageInfo(widget.pagePath);

      utils.evalJS.executePageCode(
        pageInfo["code"],
        widget.pagePath,
      );

      setState(() {
        _pageLayout.addAll(jsonDecode(pageInfo["layout"]));
      });
    })();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    utils.evalJS.unmountClientCode(widget.pagePath);
    super.dispose();
  }

  PreferredSizeWidget _computeAppBar(
    Map<String, dynamic> contextData,
    Map<String, dynamic>? appBarConfig,
  ) {
    if (appBarConfig == null) {
      return const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox(),
      );
    }
    var customContent = gato.get(appBarConfig, "content");
    if (customContent == null) {
      Widget title = T_Widgets(
          layout: gato.get(appBarConfig, "title"),
          pagePath: widget.pagePath,
          contextData: contextData);
      return AppBar(title: title);
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(gato.get(customContent, "height") ?? 120),
      child: T_Widgets(
        layout: customContent,
        pagePath: widget.pagePath,
        contextData: contextData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var contextData = context.watch<ContextStateProvider>().contextData;
    var customAppBar = gato.get(_pageLayout, "appBar");

    return Scaffold(
      appBar: _computeAppBar(
        contextData,
        customAppBar,
      ),
      body: Container(
        child: Column(
          children: [
            T_Widgets(
              layout: _pageLayout,
              pagePath: widget.pagePath,
              contextData: contextData,
            ),
            Text(" ${contextData}"),
          ],
        ),
      ),
    );
  }
}
