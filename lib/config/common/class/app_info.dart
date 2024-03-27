import 'dart:io';

import 'package:device_apps/device_apps.dart';

class AppInfo {
  String response = "";

  Future<String> getAppVersion() async {
    // Fetch all the installed applications on the device
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      includeAppIcons: true,
      onlyAppsWithLaunchIntent: false,
    );
    // Sort the applications alphabetically by name
    String? versionNumber = "";
    for (var element in apps) {
      if (element.packageName
          .contains('com.example.news_app_clean_architecture')) {
        versionNumber = element.versionName;
      }
    }
    return versionNumber!;
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
