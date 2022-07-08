import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
import 'package:the_tool/page_utils/should_update.widget.dart';
import 'package:the_tool/page_utils/theme_provider.dart';
import 'package:the_tool/t_widget_interface/bottom_nav_props.dart';
import 'package:the_tool/t_widget_interface/bottom_navigation_props/bottom_navigation_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';
import 'package:provider/provider.dart';
import 'package:gato/gato.dart' as gato;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class T_Page extends StatefulWidget {
  String pagePath;
  T_Page({Key? key, required this.pagePath}) : super(key: key);

  @override
  State<T_Page> createState() => _T_Page();
}

class _T_Page extends State<T_Page> with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> _prevPageState = {};
  Map<String, dynamic> _initPageState = {};
  Map<String, dynamic> _pageLayout = {};
  bool _isReadyToRun = false;

  late UtilsManager utils;
  List<Widget> _pages = [];

  int _selectedBottomNavIndex = 0;
  var _customAppBar;
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
    var pageData = context.select((ContextStateProvider value) {
      Map<String, dynamic> emptyData = {};
      var data = value.contextData[widget.pagePath] ?? emptyData;
      return data;
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

    return Scaffold(
      appBar: _computeAppBar(
        pageData,
        _customAppBar,
      ),
      bottomNavigationBar: _computeBottomNavigationBar(
        pageData,
        _bottomNavBar,
      ),
      body: SafeArea(
        child: _getSelectedPage(
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

    _pageLayout.addAll(layout);
    _customAppBar = gato.get(_pageLayout, "appBar");
    _bottomNavBar =
        BottomNavigationProps.fromJson(_pageLayout["bottomNav"] ?? {});
  }

  Widget _getSelectedPage(
    Map<String, dynamic> contextData,
    int selectedBottomNavIndex,
  ) {
    if (_bottomNavBar == null || _bottomNavBar?.items == null) {
      return T_Widgets(
        layout: _pageLayout,
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
    if (bottomNavConfig == null || bottomNavConfig.items == null) {
      return [];
    }

    var items = bottomNavConfig.items;
    List<Widget> pages = (items ?? []).map((item) {
      if (item.path == null) {
        throw Exception("Please provide path in bottom navigation iten");
      }

      Key pageKey = Key(item.path!);
      return T_Page(
        key: pageKey,
        pagePath: item.path!,
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
    Map<String, dynamic>? appBarConfig,
  ) {
    if (appBarConfig == null) {
      return null;
    }

    if (appBarConfig["content"] != null) {
      Widget title = T_Widgets(
        layout: appBarConfig["content"],
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
            icon: Icon(Icons.light_mode),
          ),
        ],
      );
    }

    var customContent = gato.get(appBarConfig, "custom");
    return PreferredSize(
      preferredSize: Size.fromHeight(gato.get(customContent, "height") ?? 120),
      child: T_Widgets(
        layout: customContent,
        pagePath: widget.pagePath,
        contextData: contextData,
      ),
    );
  }
}
