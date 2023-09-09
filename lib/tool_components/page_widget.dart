import 'dart:async';

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:modular_core/modular_core.dart';
import 'package:the_tool/api/client_api.dart';
import 'package:the_tool/page_provider/context_state_provider.dart';
import 'package:the_tool/page_utils/debouncer.dart';
import 'package:the_tool/page_provider/resize_provider.dart';
import 'package:the_tool/page_provider/theme_provider.dart';
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
import 'package:uuid/uuid.dart';
import 'package:the_tool/twidget_props.dart';

class TPage extends StatefulWidget {
  String pagePath;
  ModularArguments? modularArguments;

  TPage({
    Key? key,
    required this.pagePath,
    this.modularArguments,
  }) : super(key: key);

  @override
  State<TPage> createState() => _TPage();
}

final updateThemeDataToJSDebouncer = Debouncer(
  delay: const Duration(milliseconds: 50),
);

class _TPage extends State<TPage> with AutomaticKeepAliveClientMixin {
  LayoutProps? _pageLayout;
  bool _isReadyToRun = false;
  LayoutProps? _appBarLayout;

  late String _pageId;
  final Map<String, String> _pageIdMap = {};

  late UtilsManager utils;
  List<Widget> _pages = [];

  int _selectedBottomNavIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<void> _loadNecessaryWidget;
  late Future<void> _debounceLoadingBody;
  late Future<void> _debounceLoadingAppbar;
  MediaQueryData? _prevMediaQueryData;
  final commonDelay = const Duration(milliseconds: 100);

  @override
  void initState() {
    _pageId = "${widget.pagePath}_${const Uuid().v4()}";
    utils = getIt<UtilsManager>();

    /// Only load necessary widget base on page json
    _loadNecessaryWidget = _loadTWidget();

    _debounceLoadingBody = Future.delayed(commonDelay);
    _debounceLoadingAppbar = Future.delayed(commonDelay);
    super.initState();
  }

  @override
  void didChangeDependencies() {
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
    List<Future<dynamic>> futures = [];

    if (_appBarLayout != null) {
      futures.add(t_appbar.loadLibrary());
    }
    if (_pageLayout?.bottomNav != null) {
      futures.add(t_bottom_nav.loadLibrary());
    }
    if (_pageLayout?.drawer != null) {
      futures.add(t_drawer.loadLibrary());
    }

    await Future.wait(futures);

    setState(() {
      _isReadyToRun = true;
    });
  }

  int? _prevThemeRefeshToken;

  void _updateThemeDataJSON(
    ThemeData theme,
  ) {
    final themeProvider = getIt<ThemeProvider>();
    final themeDataAsJSON = ThemeEncoder.encodeThemeData(theme);
    themeProvider.themeDataAsJSON = themeDataAsJSON;

    updateThemeDataToJSDebouncer.run(() {
      themeProvider.refreshThemeData();
      _prevThemeRefeshToken = utils.themeProvider.themeRefreshToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // var pageData = Map<String, dynamic>.from({"_tLoaded": true});

    var pageData = context.select((ContextStateProvider value) {
      return value.contextData[_pageId] ?? UtilsManager.emptyMapStringDynamic;
    });

    // FIXME: Do we need this. Find the way to let user have dynamic style select
    // _updateThemeOnJSSide(themeDataAsJSON);

    if (_isReadyToRun == false ||
        !UtilsManager.isTruthy(
          UtilsManager.get(pageData, "_tLoaded"),
        )) {
      return const Scaffold(
        body: Center(child: Text("Loading...")),
      );
    }

    var contextStateProvider = getIt<ContextStateProvider>();
    contextStateProvider.setRootPageData(pageData);
    final mediaQueryData = MediaQuery.of(context);

    var theme = Theme.of(context);
    if (_prevThemeRefeshToken != utils.themeProvider.themeRefreshToken) {
      _updateThemeDataJSON(theme);
    }

    getIt<ResizeProvider>().resize(mediaQueryData.size);
    // print("Update page: ${_pageId} $pageData");

    return FutureBuilder(
      // key: ValueKey(_pageId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Offstage();
        }

        _updateMediaQueryInJS(mediaQueryData);

        var page = Scaffold(
          key: _scaffoldKey,
          appBar: _getAppBar(pageData),
          bottomNavigationBar: _pageLayout?.bottomNav == null
              ? null
              : FutureBuilder(
                  future: _debounceLoadingAppbar,
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? _getBottomNavigation(pageData)!
                        : const Offstage();
                  },
                ),
          drawer: _computeDrawer(pageData),
          body: FutureBuilder(
            future: _debounceLoadingBody,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? _getSelectedPage(
                      pageData,
                      _selectedBottomNavIndex,
                    )
                  : const Offstage();
            },
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
  }

  Future<void> _loadPageInfo() async {
    var contextStateProvider = getIt<ContextStateProvider>();
    var apiClient = getIt<APIClientManager>();

    Map<String, dynamic> pageInfo =
        await apiClient.getClientPageInfo(widget.pagePath);

    utils.evalJS?.executePageCode(
      clientCode: pageInfo["code"],
      pagePath: _pageId,
    );

    utils.evalJS?.addClientPage(_pageId);

    var layout = pageInfo["layout"];

    if (layout["appBar"] != null) {
      _appBarLayout = LayoutProps.fromJson(layout["appBar"]);
    }

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
        childData: const {},
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
    _pageIdMap.putIfAbsent(pagePath, () => UniqueKey().toString());
    return _pageIdMap[pagePath]!;
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  Widget? _computeDrawer(
    Map<String, dynamic> contextData,
  ) {
    if (_pageLayout?.drawer == null) return null;

    return t_drawer.TDrawer(
      TWidgetProps(
        pagePath: _pageId,
        widgetProps: _pageLayout?.drawer?.child ?? const LayoutProps(),
        drawerProps: _pageLayout?.drawer,
        widgetUuid: _pageId,
        childData: contextData,
      ),
    );
  }

  Widget? _getBottomNavigation(Map<String, dynamic> contextData) {
    if (_pageLayout?.bottomNav == null) {
      return null;
    }
    return t_bottom_nav.computeBottomNavigationBar(
      _pageId,
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

    if (UtilsManager.isEquals(
      _prevMediaQueryData,
      mediaQuery,
    )) {
      return;
    }

    _prevMediaQueryData = mediaQuery;
    utils.evalJS?.callJS("_onMediaQueryChanged", _pageId, [
      {
        "height": height,
        "width": width,
        "orientation": orientation,
      }
    ]);
  }

  dynamic _getAppBar(Map<String, dynamic> contextData) {
    if (_appBarLayout == null) {
      return null;
    }
    return t_appbar.computeAppBar(_pageId, _appBarLayout);
  }
}
