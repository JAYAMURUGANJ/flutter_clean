import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/common/class/error_logger.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('CubitObserver onChange: (${bloc.runtimeType}, $change)');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('CubitObserver onError: (${bloc.runtimeType}, $error, $stackTrace)');
    ErrorLogger().log(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
