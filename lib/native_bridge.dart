import 'package:flutter/services.dart';

class NativeBridge {
  static const _channel = MethodChannel(
    'com.example.native_code_integrations/native_service',
  );

  static Future<String?> getDeviceVersion() async {
    try {
      // Invoke native method 'getOSVersion'
      final String? version = await _channel.invokeMethod('getOSVersion');
      return version;
    } on PlatformException catch (e) {
      print("Failed to get version: '${e.message}'.");
      return null;
    }
  }

  static Future<void> makeCall(String number) async {
    try {
      await _channel.invokeMethod('makeCall', {'phoneNumber': number});
    } on PlatformException catch (e) {
      print("Failed to make call: '${e.message}'.");
    }
  }
}
