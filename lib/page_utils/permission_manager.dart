// import 'package:permission_handler/permission_handler.dart';

// class PermissionManager {
//   static Map<String, int> permissionValue = {
//     "calendar": 0,
//     "camera": 1,
//     "contacts": 2,
//     "location": 3,
//     "locationAlways": 4,
//     "locationWhenInUse": 5,
//     "mediaLibrary": 6,
//     "microphone": 7,
//     "phone": 8,
//     "photos": 9,
//     "photosAddOnly": 10,
//     "reminders": 11,
//     "sensors": 12,
//     "sms": 13,
//     "speech": 14,
//     "storage": 15,
//     "ignoreBatteryOptimizations": 16,
//     "notification": 17,
//     "accessMediaLocation": 18,
//     "activityRecognition": 19,
//     "unknown": 20,
//     "bluetooth": 21,
//     "manageExternalStorage": 22,
//     "systemAlertWindow": 23,
//     "requestInstallPackages": 24,
//     "appTrackingTransparency": 25,
//     "criticalAlerts": 26,
//     "accessNotificationPolicy": 27,
//     "bluetoothScan": 28,
//     "bluetoothAdvertise": 29,
//     "bluetoothConnect": 30,
//   };

//   Future<PermissionStatus?> requestPermission(String permissionName) async {
//     var permission = _getPermissionByName(permissionName);
//     return permission?.request();
//   }

//   Future<PermissionStatus?> getPermissionStatus(String permissionName) {
//     var permission = _getPermissionByName(permissionName);
//     return Future.value(permission?.status);
//   }

//   Future<bool> requestOpenAppSettings() async {
//     return await openAppSettings();
//   }

//   Map<String, bool> permissionStatusToMap(PermissionStatus? permissionStatus) {
//     if (permissionStatus == null) {
//       return {};
//     }

//     return {
//       "isGranted": permissionStatus.isGranted,
//       "isDenied": permissionStatus.isDenied,
//       "isLimited": permissionStatus.isLimited,
//       "isPermanentlyDenied": permissionStatus.isPermanentlyDenied,
//       "isRestricted": permissionStatus.isRestricted
//     };
//   }

//   Permission? _getPermissionByName(String permissionName) {
//     if (permissionValue.containsKey(permissionName)) {
//       return Permission.byValue(permissionValue[permissionName]!);
//     }
//     return null;
//   }
// }
