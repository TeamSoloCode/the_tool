import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<PermissionStatus?> requestPermission(String permissionName) async {
    var permission = _getPermissionByName(permissionName);
    return permission?.request();
  }

  Future<PermissionStatus?> getPermissionStatus(String permissionName) {
    var permission = _getPermissionByName(permissionName);
    return Future.value(permission?.status);
  }

  PermissionWithService? _getPermissionByName(String permissionName) {
    switch (permissionName) {
      case 'location':
        return Permission.location;
      default:
        return null;
    }
  }
}
