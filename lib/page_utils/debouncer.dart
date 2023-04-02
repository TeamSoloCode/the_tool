library debouncer;

import 'dart:async';

typedef DebounceAction = void Function();

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(DebounceAction action) {
    _timer?.cancel();
    _timer = Timer(delay, () => action());
  }
}
