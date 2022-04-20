import 'package:flutter/foundation.dart';

class ContextStateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> _contextData = {};

  Map<String, dynamic> get contextData => _contextData;

  void updateContextData(Map<String, dynamic> contextData) {
    _contextData.addAll(contextData);
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('_contextData', _contextData));
  }
}
