import 'package:hive_flutter/adapters.dart';

class StorageManager {
  late Box _cookies;
  late Box _localStorage;
  late Box _session;
  late Box _localBox;
  late Box _routes;

  StorageManager();

  Future<void> initStorageBox() async {
    await Hive.initFlutter();

    _cookies = await Hive.openBox<dynamic>('cookies');
    _localStorage = await Hive.openBox<dynamic>('localStorage');
    _session = await Hive.openBox<dynamic>('session');
    _localBox = await Hive.openBox<dynamic>('localBox');
    _routes = await Hive.openBox<dynamic>('route');
  }

  Future<void> closeStorageBox() async {
    await Future.wait([
      Hive.box('cookies').close(),
      Hive.box('localStorage').close(),
      Hive.box('session').close(),
      Hive.box('localBox').close(),
      Hive.box('route').close()
    ]);
  }

  dynamic getCookies(String? key, {dynamic defaultValue}) {
    return _cookies.get(key, defaultValue: defaultValue);
  }

  Future<void> setCookies(String? key, dynamic value) async {
    await _cookies.put(key, value);
  }

  dynamic getLocalBox(String? key, {dynamic defaultValue}) {
    return _localBox.get(key, defaultValue: defaultValue);
  }

  Future<void> setLocalBox(String? key, dynamic value) async {
    await _localBox.put(key, value);
  }

  Future<void> setRoutes({Map<String, dynamic>? value}) {
    return _routes.put('route', value);
  }

  dynamic getRoutes() {
    return _routes.get('route');
  }
}
