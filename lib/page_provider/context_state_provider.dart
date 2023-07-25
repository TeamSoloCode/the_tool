import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

class ContextStateProvider with ChangeNotifier {
  final Map<String, dynamic> _contextData = {};
  final Map<String, dynamic> _rootPageData = {};
  Map<String, bool> _cacheCheckTWidgetDepsChanged = {};
  ClientConfig? _appConfig;
  Map<String, dynamic> initData;

  final _notifyListenersDuration = const Duration(milliseconds: 16);
  final notifyListenersController =
      StreamController<Map<String, dynamic>>(sync: true);

  ContextStateProvider({this.initData = const {}}) : super() {
    _contextData.addAll(initData);

    notifyListenersController.stream
        .interval(_notifyListenersDuration)
        .listen(_updateContextData);
  }
  // ==========================================================================
  Map<String, dynamic> get contextData => _contextData;

  Future<void> updateContextData(Map<String, dynamic> contextData) async {
    notifyListenersController.add(contextData);
  }

  Future<void> _updateContextData(Map<String, dynamic> contextData) async {
    _contextData.addAll(contextData);
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

  // ==========================================================================
  final Map<String, dynamic> _popupWidgets = Map.of({});

  Map<String, dynamic> get popupWidgets => _popupWidgets;

  void registerPopupWidgets({
    required String pagePath,
    required String popupName,
    required dynamic registerPopupWidget,
  }) {
    _popupWidgets["$pagePath:$popupName"] = registerPopupWidget;
  }

  void unregisterPopupWidgets({
    required String pagePath,
    required String popupName,
  }) {
    _popupWidgets["$pagePath:$popupName"] = null;
  }
  // ==========================================================================
}
