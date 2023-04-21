import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_tool/utils.dart';

class ResizeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final utils = getIt<UtilsManager>();
  Size? _size;
  int? _resizeRefreshKey;
  int? _prevResizeRefreshKey;

  Size? get currentSize => _size;
  int? get resizeRefreshKey => _resizeRefreshKey;
  int? get prevResizeRefreshKey => _prevResizeRefreshKey;

  void resize(Size size) {
    if (size != currentSize) {
      _size = size;
      _resizeRefreshKey = DateTime.now().millisecondsSinceEpoch;
      notifyListeners();
      _prevResizeRefreshKey = _resizeRefreshKey;
    }
  }
}
