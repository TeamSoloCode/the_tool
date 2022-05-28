import 'package:flutter/foundation.dart';

class PageContextProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic> _pageContext = {};

  Map<String, dynamic> get pageContext => _pageContext;

  void updateContext(Map<String, dynamic> contextData) {
    _pageContext.addAll(contextData);
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('_contextData', _contextData));
  }
}
