import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'config/common/class/error_logger.dart';
import 'core/bloc/bloc_observer.dart';
import 'injection_container.dart';

void main() {
  runZonedGuarded(
    () async {
      Bloc.observer = MyBlocObserver();
      await dotenv.load(fileName: ".env_dev");
      WidgetsFlutterBinding.ensureInitialized();
      await initializeDependencies();
      FlutterError.onError = FlutterError.presentError;
      runApp(const App());
    },
    (error, stackTrace) {
      ErrorLogger().log(error, stackTrace);
    },
  );
}
