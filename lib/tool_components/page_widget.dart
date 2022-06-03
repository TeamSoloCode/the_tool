import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';

import 'package:the_tool/api_client.dart';
import 'package:the_tool/page_utils/context_state_provider.dart';
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
  late List<Widget> _pages;

  int _selectedBottomNavIndex = 0;
  var _customAppBar;
  var _bottomNavBar;

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
    utils.evalJS.unmountClientCode(widget.pagePath);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (_isReadyToRun == false) {
      return const Scaffold(
        body: Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
      );
    }

    var pageData = context.select((ContextStateProvider value) {
      Map<String, dynamic> emptyData = {};
      var data = value.contextData[widget.pagePath] ?? emptyData;
      return data;
    });

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
      body: _getSelectedPage(
        pageData,
        _selectedBottomNavIndex,
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

    utils.evalJS.executePageCode(
      pageInfo["code"],
      widget.pagePath,
    );
    var layout = pageInfo["layout"];

    _pageLayout.addAll(jsonDecode(layout));
    _customAppBar = gato.get(_pageLayout, "appBar");
    _bottomNavBar = gato.get(_pageLayout, "bottomNav");
    _pages = _computeBottomNavigationPages(_bottomNavBar);
  }

  Widget _getSelectedPage(
    Map<String, dynamic> contextData,
    int selectedBottomNavIndex,
  ) {
    if (_bottomNavBar == null) {
      return T_Widgets(
        layout: _pageLayout,
        pagePath: widget.pagePath,
        contextData: contextData,
      );
    }
    return _pages.elementAt(selectedBottomNavIndex);
  }

  List<Widget> _computeBottomNavigationPages(
    Map<String, dynamic>? bottomNavConfig,
  ) {
    if (bottomNavConfig == null) {
      return [];
    }

    var items = gato.get(bottomNavConfig, "items") as List<dynamic>;

    List<Widget> pages = items.map((item) {
      Key pageKey = Key(item['path']);
      return T_Page(
        key: pageKey,
        pagePath: item["path"],
      );
    }).toList();

    return pages;
  }

  Widget? _computeBottomNavigationBar(
    Map<String, dynamic> contextData,
    Map<String, dynamic>? bottomNavConfig,
  ) {
    if (bottomNavConfig == null) {
      return null;
    }

    var items = gato.get(bottomNavConfig, "items") as List<dynamic>;
    String? cssColor = gato.get(bottomNavConfig, "selectedItemColor");
    Color? color = cssColor != null ? ThemeDecoder.decodeColor(cssColor) : null;

    List<BottomNavigationBarItem> bottomNavItems = items.map((item) {
      String? cssColor = gato.get(item, "backgroundColor");
      Color? color =
          cssColor != null ? ThemeDecoder.decodeColor(cssColor) : null;

      return BottomNavigationBarItem(
        label: item["label"],
        icon: Icon(MdiIcons.fromString(item["icon"])),
        backgroundColor: color,
      );
    }).toList();

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: bottomNavItems,
      selectedItemColor: color,
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
}
