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

  WebViewController? _webViewController;
  bool isWebViewReady = false;
  late UtilsManager utils;
  EvalJS? _evalJS;

  @override
  void initState() {
    (() async {
      if (kIsWeb) {
        _evalJS = EvalJS(
          context: context,
          contextStateProvider: context.read<ContextStateProvider>(),
        );
        APIClientManager apiClient = getIt<APIClientManager>();
        String clientCore = await apiClient.getClientCore();
        Map<String, dynamic> pageInfo =
            await apiClient.getClientPageInfo(widget.pagePath);

        _evalJS?.setupReactForClientCode(
          pageInfo["code"],
          clientCore,
          widget.pagePath,
        );

        setState(() {
          _pageLayout.addAll(jsonDecode(pageInfo["layout"]));
        });
      }
    })();

    utils = getIt<UtilsManager>();

    super.initState();
  }

  @override
  void dispose() {
    _evalJS?.unmountClientCode(widget.pagePath);
    super.dispose();
  }

  Future<void> _executeJS(String jsCode) async {
    if (kIsWeb) {
      _evalJS?.executeJS(jsCode);
    } else {
      if (!isWebViewReady) {
        throw Exception("Web View is not ready yet");
      }
      _evalJS?.executeJS(jsCode);
    }
  }

  Widget _initWebViewForMobile() {
    if (kIsWeb) {
      return const SizedBox();
    }

    return SizedBox(
      width: 0,
      height: 0,
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _webViewController = webViewController;

          _evalJS = EvalJS(
            context: context,
            webViewController: webViewController,
            contextStateProvider: context.read<ContextStateProvider>(),
          );

          APIClientManager apiClient = getIt<APIClientManager>();
          String clientCore = await apiClient.getClientCore();
          Map<String, dynamic> pageInfo =
              await apiClient.getClientPageInfo(widget.pagePath);
          setState(() {
            isWebViewReady = true;
            _pageLayout.addAll(jsonDecode(pageInfo["layout"]));
          });

          // TODO: If not have this line, it won't work
          await Future.delayed(const Duration(milliseconds: 1));

          String htmlContent = (await _evalJS?.setupReactForClientCode(
                pageInfo["code"],
                clientCore,
                widget.pagePath,
              )) ??
              "";

          _webViewController?.loadUrl(
            Uri.dataFromString(
              htmlContent,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString(),
          );
        },
        javascriptChannels: utils.registerJavascriptChannel(
          context,
          context.read<ContextStateProvider>(),
        ),
      ),
    );
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
        executeJS: _executeJS,
      );
      return AppBar(title: title);
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(gato.get(customContent, "height") ?? 120),
      child: T_Widgets(
        layout: customContent,
        executeJS: _executeJS,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _initWebViewForMobile(),
              if (isWebViewReady || kIsWeb)
                T_Widgets(
                  layout: _pageLayout,
                  executeJS: _executeJS,
                  contextData: contextData,
                ),
              Text(" $contextData"),
            ],
          ),
        ),
      ),
    );
  }
}
