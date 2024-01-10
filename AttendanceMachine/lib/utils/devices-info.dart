import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DevicesInfo {
  static DevicesInfo? _info;

  static DevicesInfo get info {
    return _info!;
  }

  static Future<void> init() async {
    try {
      var cameras = await availableCameras();
      var deviceCode = await _getId() ?? "";

      _info = DevicesInfo(
        cameras: cameras,
        deviceId: deviceCode,
        passwordManufactory: "123456"
      );
    } on CameraException catch (e) {
      print(e);
    }
  }

  static Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  DevicesInfo({
    required this.cameras,
    required this.deviceId,
    required this.passwordManufactory
  });

  final List<CameraDescription> cameras;
  final String deviceId;
  final String passwordManufactory;
}