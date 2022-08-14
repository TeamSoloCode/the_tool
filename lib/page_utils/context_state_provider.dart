import 'package:flutter/foundation.dart';

import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/utils.dart';

class ContextStateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final Map<String, dynamic> _contextData = {};
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
