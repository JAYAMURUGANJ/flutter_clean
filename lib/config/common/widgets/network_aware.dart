import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/connectivity_bloc.dart';
import '../bloc/bloc/connectivity_state.dart';
import '../pages/error/no_network_screen.dart';
import '../pages/error/something_went_wrong_screen.dart';

class NetworkAware extends StatelessWidget {
  final Widget child;

  const NetworkAware({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state.status == ConnectivityStatus.connected) {
          return child;
        } else if (state.status == ConnectivityStatus.disconnected) {
          return const NoNetWork();
        } else {
          return const SomethingWentWrong(
            error: 'Somthing Went Wrong',
          );
        }
      },
    );
  }
}
