import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

// import 'package:device_apps/device_apps.dart';

class AppInfo {
  String response = "";

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  Future<String?> getIPAddress() async {
    String? ipAddress;

    for (var interface in await NetworkInterface.list()) {
      if (interface.name == 'wlan0' || interface.name == 'en0') {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            ipAddress = addr.address;
            break;
          }
        }
      } else if (interface.name == 'rmnet_data0' ||
          interface.name == 'p2p-wlan0-0' ||
          interface.name == 'ccmni0' ||
          interface.name == 'rmnet_usb0') {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            ipAddress = addr.address;
            break;
          }
        }
      }
    }
    return ipAddress;
  }
}
