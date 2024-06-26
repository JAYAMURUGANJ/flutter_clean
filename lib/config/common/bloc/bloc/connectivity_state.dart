// connectivity_state.dart
import 'package:equatable/equatable.dart';

enum ConnectivityStatus { initial, connected, disconnected }

class ConnectivityState extends Equatable {
  final ConnectivityStatus status;

  const ConnectivityState(this.status);

  @override
  List<Object> get props => [status];
}
