import 'package:flutter/material.dart';
import 'package:the_tool/utils.dart';
import 'package:the_tool/page_utils/debouncer.dart';

class ResizeProvider with ChangeNotifier {
  final utils = getIt<UtilsManager>();
  final resizeDebouncer = Debouncer(delay: const Duration(milliseconds: 300));

  Size? _size;
  int? _resizeRefreshKey;
  int? _prevResizeRefreshKey;

  Size? get currentSize => _size;
  int? get resizeRefreshKey => _resizeRefreshKey;
  int? get prevResizeRefreshKey => _prevResizeRefreshKey;

  void resize(Size size) {
    resizeDebouncer.run(() {
      if (size != currentSize) {
        _size = size;
        _resizeRefreshKey = DateTime.now().millisecondsSinceEpoch;
        notifyListeners();
        _prevResizeRefreshKey = _resizeRefreshKey;
      }
    });
  }
}
