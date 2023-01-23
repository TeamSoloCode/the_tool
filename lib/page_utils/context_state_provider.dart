import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';

class ContextStateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final Map<String, dynamic> _contextData = {};
  final Map<String, dynamic> _rootPageData = {};
  Map<String, bool> _cacheCheckTWidgetDepsChanged = {};
  ClientConfig? _appConfig;
  Map<String, dynamic> initData;

  ContextStateProvider({this.initData = const {}}) : super() {
    _contextData.addAll(initData);
  }
  // ==========================================================================
  Map<String, dynamic> get contextData => _contextData;

  Future<void> updateContextData(Map<String, dynamic> contextData) async {
    _contextData.addAll(contextData);
    _cacheCheckTWidgetDepsChanged = {};
    // getIt<PageContextProvider>().updateTWidgetProps(_contextData);
    notifyListeners();
  }

  void updateCacheCheckTWidgetDepsChanged(String depsKey, bool isDepsChanged) {
    _cacheCheckTWidgetDepsChanged.putIfAbsent(depsKey, () => isDepsChanged);
  }
  // ==========================================================================

  // ==========================================================================
  final Map<String, GlobalKey<ScaffoldState>> _mapKeyScaffoldState = {};
  Map<String, GlobalKey<ScaffoldState>> get mapKeyScaffoldState =>
      _mapKeyScaffoldState;

  void registerKeyScaffoldState(
      String pagePath, GlobalKey<ScaffoldState> context) {
    _mapKeyScaffoldState.putIfAbsent(pagePath, () => context);
  }

  void unregisterKeyScaffoldState(String pagePath) {
    _mapKeyScaffoldState.remove(pagePath);
  }

  // ==========================================================================

  // ==========================================================================
  Map<String, dynamic> get rootPageData => _rootPageData;

  Future<void> setRootPageData(Map<String, dynamic> data) async {
    _rootPageData.clear();
    _rootPageData.addAll(data);
  }
  // ==========================================================================

  // ==========================================================================
  Map<String, bool> get cacheCheckTWidgetDepsChanged =>
      _cacheCheckTWidgetDepsChanged;

  ClientConfig? get appConfig => _appConfig;

  set appConfig(ClientConfig? contextConfig) {
    _appConfig = contextConfig;
    notifyListeners();
  }
  // ==========================================================================

  // ==========================================================================
  final Map<String, Map<String, LayoutProps?>> _pageComponents = Map.of({});

  Map<String, Map<String, LayoutProps?>> get pageComponents => _pageComponents;

  void addPageComponents({
    required String pagePath,
    required Map<String, LayoutProps?> components,
  }) {
    _pageComponents.putIfAbsent(pagePath, () => components);
  }
  // ==========================================================================

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('_contextData', _contextData));
  }
}
