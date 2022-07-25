import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:the_tool/page_utils/twidget_context_provider.dart';

import 'package:the_tool/t_widget_interface/client_config/client_config.dart';
import 'package:the_tool/utils.dart';

class ContextStateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> _contextData = {};
  ClientConfig? _appConfig;
  Map<String, dynamic> initData;

  ContextStateProvider({this.initData = const {}}) : super() {
    _contextData.addAll(initData);
  }

  Map<String, dynamic> get contextData => _contextData;

  Future<void> updateContextData(Map<String, dynamic> contextData) async {
    _contextData.addAll(contextData);
    notifyListeners();
    // getIt<PageContextProvider>().updateTWidgetProps(_contextData);
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
