import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/t_widget_interface/app_bar_props/app_bar_props.dart';
import 'package:the_tool/t_widget_interface/bottom_nav_props.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  late UtilsManager utils;
  List<Widget> _pages = [];

  int _selectedBottomNavIndex = 0;
  AppBarProps? _customAppBar;
  BottomNavigationProps? _bottomNavBar;

  @override
  void initState() {
    utils = getIt<UtilsManager>();
    _startLoadingData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    utils.evalJS?.unmountClientCode(widget.pagePath);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  ThemeMode? prevThemeMode;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // var pageData = Map<String, dynamic>.from({"_tLoaded": true});
    var pageData = context.select((ContextStateProvider value) {
      return value.contextData[widget.pagePath] ?? {"": null};
    });

    if (_isReadyToRun == false ||
        UtilsManager.isFalsy(gato.get(pageData, "_tLoaded"))) {
      return const Scaffold(
        body: Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
      );
    }

    log("Update page: ${widget.pagePath} $pageData");

    return SafeArea(
      child: Scaffold(
        appBar: _computeAppBar(
          pageData,
          _customAppBar,
        ),
        bottomNavigationBar: _computeBottomNavigationBar(
          pageData,
          _bottomNavBar,
        ),
        body: _getSelectedPage(
          pageData,
          _selectedBottomNavIndex,
        ),
      ),
    );
  }

  Future<void> _startLoadingData() async {
    await _loadPageInfo();
    setState(() {
      _isReadyToRun = true;
    });
  }

  Future<void> _loadPageInfo() async {
    APIClientManager apiClient = getIt<APIClientManager>();
    Map<String, dynamic> pageInfo =
        await apiClient.getClientPageInfo(widget.pagePath);

    utils.evalJS?.executePageCode(
      pageInfo["code"],
      widget.pagePath,
    );
    var layout = pageInfo["layout"];

    _pageLayout = LayoutProps.fromJson(layout);
    _customAppBar = _pageLayout?.appBar;
    _bottomNavBar = _pageLayout?.bottomNav;
  }

  Widget _getSelectedPage(
    Map<String, dynamic> contextData,
    int selectedBottomNavIndex,
  ) {
    if (_bottomNavBar == null || _bottomNavBar?.items == null) {
      return TWidgets(
        layout: _pageLayout ?? const LayoutProps(),
        pagePath: widget.pagePath,
        contextData: contextData,
      );
    }
    _pages = _computeBottomNavigationPages(_bottomNavBar);
    return _pages.elementAt(selectedBottomNavIndex);
  }

  List<Widget> _computeBottomNavigationPages(
    BottomNavigationProps? bottomNavConfig,
  ) {
    var size = MediaQuery.of(context).size;
    if (bottomNavConfig == null || bottomNavConfig.items == null) {
      return [];
    }

    var items = bottomNavConfig.items;
    List<Widget> pages = (items ?? []).map((item) {
      if (item.path == null) {
        throw Exception("Please provide path in bottom navigation iten");
      }

      ValueKey pageKey = ValueKey(item.path!);

      return SizedBox(
        height: size.height,
        width: size.width,
        child: T_Page(
          key: pageKey,
          pagePath: item.path!,
        ),
      );
    }).toList();

    return pages;
  }

  Widget? _computeBottomNavigationBar(
    Map<String, dynamic> contextData,
    BottomNavigationProps? bottomNavConfig,
  ) {
    if (bottomNavConfig == null || bottomNavConfig.items == null) {
      return null;
    }

    var bottomNavProps = DecodeBottomNavigation(
      bottomNavConfig: bottomNavConfig,
    );

    return BottomNavigationBar(
      type: bottomNavProps.type,
      items: bottomNavProps.items,
      selectedItemColor: bottomNavProps.selectedItemColor,
      currentIndex: _selectedBottomNavIndex,
      onTap: _onBottomNavItemTapped,
    );
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  PreferredSizeWidget? _computeAppBar(
    Map<String, dynamic> contextData,
    AppBarProps? appBarConfig,
  ) {
    if (appBarConfig == null) {
      return null;
    }

    if (appBarConfig.content != null) {
      Widget title = TWidgets(
        layout: appBarConfig.content!,
        pagePath: widget.pagePath,
        contextData: contextData,
      );

      // List<Widget> actions = (appBarConfig["actions"] as List<dynamic>).map(
      //   (e) {
      //     return SizedBox();
      //   },
      // ).toList();

      return AppBar(
        title: title,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.light_mode),
          ),
        ],
      );
    }

    var customContent = gato.get(appBarConfig, "custom");
    return PreferredSize(
      preferredSize: Size.fromHeight(gato.get(customContent, "height") ?? 120),
      child: TWidgets(
        layout: customContent,
        pagePath: widget.pagePath,
        contextData: contextData,
      ),
    );
  }
}
