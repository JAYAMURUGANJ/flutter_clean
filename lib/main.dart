// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/app.dart';
import 'config/common/class/app_info.dart';
import 'config/common/class/error_logger.dart';
import 'config/common/class/local_storage.dart';
import 'core/bloc/bloc_observer.dart';
import 'injection_container.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      String envFile = ".env_uat"; // Default environment file
      const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'uat');
      switch (flavor) {
        case 'prod':
          envFile = ".env_prod";
          break;
        case 'uat':
          envFile = ".env_uat";
          break;
      }
      await dotenv.load(fileName: envFile);
      Bloc.observer = MyBlocObserver();
      await initializeDependencies();
      await Prefs.init();
      await Locales.init(['ta', 'en']);
      AppInfo().getIPAddress().then((ip) async {
        await Prefs.setString(
            spNetworkIp, ip == null ? "No Network" : ip.toString());
      });
      AppInfo().getAppVersion().then((version) async {
        await Prefs.setString(
            spAppVersion, version == null ? "Not Found" : version.toString());
      });
      FlutterError.onError = FlutterError.presentError;

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then(
        (value) => runApp(
          DevicePreview(
            enabled: envFile == ".env_uat",
            builder: (context) => App(
              environment: envFile,
            ), // Wrap your app
          ),
        ),
      );
    },
    (error, stackTrace) {
      ErrorLogger().log(error, stackTrace);
    },
  );
}
