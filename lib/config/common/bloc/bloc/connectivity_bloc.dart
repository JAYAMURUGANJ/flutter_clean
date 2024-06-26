// connectivity_bloc.dart
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc(this._connectivity)
      : super(const ConnectivityState(ConnectivityStatus.initial)) {
    on<ConnectivityChanged>((event, emit) {
      emit(ConnectivityState(event.status));
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      add(ConnectivityChanged(_mapConnectivityResultToStatus(result)));
    });
  }

  ConnectivityStatus _mapConnectivityResultToStatus(
      List<ConnectivityResult> result) {
    switch (result.first) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn:
        return ConnectivityStatus.connected;
      case ConnectivityResult.none:
      default:
        return ConnectivityStatus
            .disconnected; // Optional: handle unexpected cases
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
