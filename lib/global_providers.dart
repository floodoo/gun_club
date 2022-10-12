import "dart:io";

import "package:device_info_plus/device_info_plus.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:gun_club/src/core/models/device_info.dart";

late final Provider<DeviceInfo> deviceInfoProvider;

Future<void> initGlobalProviders() async {
  ///
  /// Device Info
  ///
  final deviceInfoPlugin = DeviceInfoPlugin();
  late final DeviceInfo deviceInfo;

  if (!kIsWeb) {
    if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceInfo = DeviceInfo(
        model: androidDeviceInfo.model,
        uuid: androidDeviceInfo.id,
        platform: Platform.operatingSystem,
      );
    } else if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceInfo = DeviceInfo(
        model: iosDeviceInfo.model,
        uuid: iosDeviceInfo.identifierForVendor,
        platform: Platform.operatingSystem,
      );
    }
  } else {
    final webDeviceInfo = await deviceInfoPlugin.webBrowserInfo;
    deviceInfo = DeviceInfo(
      model: webDeviceInfo.browserName.name,
      uuid: webDeviceInfo.userAgent,
      platform: "web",
    );
  }

  deviceInfoProvider = Provider<DeviceInfo>((ref) {
    return deviceInfo;
  });
}
