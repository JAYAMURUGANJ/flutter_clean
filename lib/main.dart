// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'config/common/class/app_info.dart';
import 'config/common/class/error_logger.dart';
import 'config/common/class/local_storage.dart';
import 'core/bloc/bloc_observer.dart';
import 'injection_container.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      Bloc.observer = MyBlocObserver();
      await dotenv.load(fileName: ".env_dev");
      WidgetsFlutterBinding.ensureInitialized();
      await initializeDependencies();
      await Prefs.init();
      await Locales.init(['en', 'ta']);
      await Prefs.setString(spLocalLanguage, 'EN');
      AppInfo().getIPAddress().then((ip) async {
        debugPrint("Network Ip: $ip");
        await Prefs.setString(
            spNetworkIp, ip == null ? "No Network" : ip.toString());
      });
      AppInfo().getAppVersion().then((version) async {
        debugPrint("App Version: $version");
        await Prefs.setString(
            spAppVersion, version == null ? "Not Found" : version.toString());
      });
      FlutterError.onError = FlutterError.presentError;
      runApp(const App());
    },
    (error, stackTrace) {
      ErrorLogger().log(error, stackTrace);
    },
  );
}
