import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionService {
  static Future<void> initialize() async {
    // Initialize permission handling
    await _checkInitialPermissions();
  }
  
  static Future<void> _checkInitialPermissions() async {
    await requestNotificationPermission();
  }
  
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
  
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }
  
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
  
  static Future<bool> requestPhotosPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }
  
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }
  
  static Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }
  
  static Future<bool> requestPhonePermission() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }
  
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }
  
  static Future<bool> requestMediaPermissions() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
      Permission.photos,
    ].request();
    
    return statuses.values.every((status) => status.isGranted);
  }
  
  static Future<bool> checkCameraPermission() async {
    return await Permission.camera.isGranted;
  }
  
  static Future<bool> checkMicrophonePermission() async {
    return await Permission.microphone.isGranted;
  }
  
  static Future<bool> checkStoragePermission() async {
    return await Permission.storage.isGranted;
  }
  
  static Future<bool> checkPhotosPermission() async {
    return await Permission.photos.isGranted;
  }
  
  static Future<bool> checkLocationPermission() async {
    return await Permission.location.isGranted;
  }
  
  static Future<bool> checkContactsPermission() async {
    return await Permission.contacts.isGranted;
  }
  
  static Future<bool> checkNotificationPermission() async {
    return await Permission.notification.isGranted;
  }
  
  static Future<void> showPermissionDialog({
    required BuildContext context,
    required String permission,
    required String reason,
    required VoidCallback onGranted,
    VoidCallback? onDenied,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permission Permission Required'),
          content: Text(reason),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDenied?.call();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Settings'),
            ),
          ],
        );
      },
    );
  }
  
  static Future<bool> handlePermissionWithDialog({
    required BuildContext context,
    required Permission permission,
    required String permissionName,
    required String reason,
  }) async {
    final status = await permission.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      if (context.mounted) {
        showPermissionDialog(
          context: context,
          permission: permissionName,
          reason: reason,
          onGranted: () {},
        );
      }
      return false;
    } else {
      return false;
    }
  }
}