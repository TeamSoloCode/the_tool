import 'package:hive_flutter/adapters.dart';

class StorageManager {
  late Box _cookies;
  late Box _localStorage;
  late Box _session;

  StorageManager();

  Future<void> initStorageBox() async {
    await Hive.initFlutter();

    _cookies = await Hive.openBox<dynamic>('cookies');
    _localStorage = await Hive.openBox<dynamic>('localStorage');
    _session = await Hive.openBox<dynamic>('session');
  }

  Future<void> closeStorageBox() async {
    await Future.wait([
      Hive.box('cookies').close(),
      Hive.box('localStorage').close(),
      Hive.box('session').close(),
    ]);
  }

  dynamic getCookies(String? key, {dynamic defaultValue}) {
    return _cookies.get(key, defaultValue: defaultValue);
  }

  Future<void> setCookies(String? key, dynamic value) async {
    await _cookies.put(key, value);
  }
}
