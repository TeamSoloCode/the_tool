import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';

class PageContextProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, LayoutProps> _tWidgetsProps = {};

  Map<String, dynamic> get tWidgetsProps => _tWidgetsProps;

  void updateTWidgetsProps(String key, LayoutProps nextProps) {
    _tWidgetsProps.update(
      key,
      (prevProps) {
        return prevProps.merge(nextProps);
      },
      ifAbsent: () {
        return nextProps;
      },
    );

    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('_contextData', _contextData));
  }
}
