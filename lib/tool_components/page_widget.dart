import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_appbar_widget.dart'
    deferred as t_appbar;
import 'package:the_tool/tool_components/t_bottom_nav_widget.dart'
    deferred as t_bottom_nav;
import 'package:the_tool/tool_components/t_drawer.widget.dart'
    deferred as t_drawer;
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

class T_Page extends StatefulWidget {
  String pagePath;
  T_Page({Key? key, required this.pagePath}) : super(key: key);

  @override
  State<T_Page> createState() => _T_Page();
}

class _T_Page extends State<T_Page> with AutomaticKeepAliveClientMixin {
  final Map<String, dynamic> _prevPageState = {};
  final Map<String, dynamic> _initPageState = {};
  LayoutProps? _pageLayout;
  bool _isReadyToRun = false;

  late String _pageId;
  final Map<String, String> _pageIdMap = {};

  late UtilsManager utils;
  List<Widget> _pages = [];

  int _selectedBottomNavIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late Future<void> _loadNecessaryWidget;
  MediaQueryData? _prevMediaQueryData;
  @override
  void initState() {
    _pageId = widget.pagePath + const Uuid().v4();
    utils = getIt<UtilsManager>();

    /// Only load necessary widget base on page json
    _loadNecessaryWidget = _loadTWidget();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    utils.evalJS?.unmountClientCode(_pageId);
    getIt<ContextStateProvider>().unregisterKeyScaffoldState(_pageId);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _loadTWidget() async {
    await _startLoadingData();
    if (_pageLayout?.appBar != null) {
      await t_appbar.loadLibrary();
    }
    if (_pageLayout?.bottomNav != null) {
      await t_bottom_nav.loadLibrary();
    }
    if (_pageLayout?.drawer != null) {
      await t_drawer.loadLibrary();
    }
  }

  ThemeMode? prevThemeMode;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // var pageData = Map<String, dynamic>.from({"_tLoaded": true});
    var pageData = context.select((ContextStateProvider value) {
      return value.contextData[_pageId] ?? UtilsManager.emptyMapStringDynamic;
    });
    var contextStateProvider = getIt<ContextStateProvider>();
    contextStateProvider.setRootPageData(pageData);
    var mediaQueryData = MediaQuery.of(context);

    if (_isReadyToRun == false ||
        !UtilsManager.isTruthy(gato.get(pageData, "_tLoaded"))) {
      return const Scaffold(
        body: Center(child: Text("Loading...")),
      );
    }

    debugPrint("Update page: ${_pageId} $pageData");

    return FutureBuilder(
      // key: ValueKey(_pageId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }

        _updateMediaQueryInJS(mediaQueryData);

        var page = SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: _getAppBar(pageData),
            bottomNavigationBar: _getBottomNavigation(pageData),
            drawer: _pageLayout?.drawer != null
                ? t_drawer.T_Drawer(
                    pagePath: widget.pagePath,
                    childProps: _pageLayout?.drawer?.child,
                    drawerProps: _pageLayout?.drawer,
                    widgetUuid: _pageId,
                    childData: pageData,
                  )
                : null,
            body: _getSelectedPage(
              pageData,
              _selectedBottomNavIndex,
            ),
          ),
        );

        // register page context
        contextStateProvider.registerKeyScaffoldState(_pageId, _scaffoldKey);

        return page;
      },
      future: _loadNecessaryWidget,
    );
  }

  Future<void> _startLoadingData() async {
    await _loadPageInfo();
    setState(() {
      _isReadyToRun = true;
    });
  }

  Future<void> _loadPageInfo() async {
    var contextStateProvider = getIt<ContextStateProvider>();
    var apiClient = getIt<APIClientManager>();

    Map<String, dynamic> pageInfo =
        await apiClient.getClientPageInfo(widget.pagePath);

    utils.evalJS?.executePageCode(pageInfo["code"], _pageId);

    var layout = pageInfo["layout"];

    _pageLayout = LayoutProps.fromJson(layout);
    if (_pageLayout?.components != null) {
      contextStateProvider.addPageComponents(
        pagePath: _pageId,
        components: _pageLayout!.components!,
      );
    }
  }

  Widget _getSelectedPage(
    Map<String, dynamic> contextData,
    int selectedBottomNavIndex,
  ) {
    if (_pageLayout?.bottomNav == null ||
        _pageLayout?.bottomNav?.items == null) {
      return TWidgets(
        layout: _pageLayout ?? const LayoutProps(),
        pagePath: _pageId,
      );
    }
    _pages = t_bottom_nav.computeBottomNavigationPages(
      context,
      _pageLayout?.bottomNav,
      updatePageIdMap: _updatePageIdMap,
    );
    return _pages.elementAt(selectedBottomNavIndex);
  }

  String _updatePageIdMap(String pagePath) {
    _pageIdMap.putIfAbsent(pagePath, () => const Uuid().v4());
    return _pageIdMap[pagePath]!;
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  Widget? _getBottomNavigation(Map<String, dynamic> contextData) {
    if (_pageLayout?.bottomNav == null) {
      return null;
    }
    return t_bottom_nav.computeBottomNavigationBar(
      contextData,
      _pageLayout?.bottomNav,
      currentIndex: _selectedBottomNavIndex,
      onTap: _onBottomNavItemTapped,
    );
  }

  /// Set media query data into React component state at $mediaQuery state
  void _updateMediaQueryInJS(MediaQueryData mediaQuery) {
    var size = mediaQuery.size;
    var height = size.height;
    var width = size.width;
    var orientation = mediaQuery.orientation.name;

    if (const DeepCollectionEquality().equals(
      _prevMediaQueryData,
      mediaQuery,
    )) {
      return;
    }

    _prevMediaQueryData = mediaQuery;
    utils.evalJS?.executeJS(
      """
        _onMediaQueryChanged(
          { 
            height: $height,
            width: $width,
            orientation: "$orientation",
          }
        )
      """,
      _pageId,
    );
  }

  dynamic _getAppBar(Map<String, dynamic> contextData) {
    if (_pageLayout?.appBar == null) {
      return null;
    }
    return t_appbar.computeAppBar(_pageId, _pageLayout?.appBar);
  }
}
