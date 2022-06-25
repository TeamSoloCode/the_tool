import 'package:flutter/foundation.dart';

import 'package:the_tool/t_widget_interface/client_config.dart';

class ContextStateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> _contextData = {};
  ClientConfig? _appConfig;
  Map<String, dynamic> initData;

  ContextStateProvider({this.initData = const {}}) : super() {
    _contextData.addAll(initData);
  }

  Map<String, dynamic> get contextData => _contextData;

  void updateContextData(Map<String, dynamic> contextData) {
    _contextData.addAll(contextData);
    notifyListeners();
  }

  ClientConfig? get appConfig => _appConfig;

  set appConfig(ClientConfig? contextConfig) {
    _appConfig = contextConfig;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('_contextData', _contextData));
  }
}
