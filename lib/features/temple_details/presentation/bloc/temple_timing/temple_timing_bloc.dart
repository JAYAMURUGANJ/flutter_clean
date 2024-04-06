import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temple_timing_event.dart';
part 'temple_timing_state.dart';

class TempleTimingBloc extends Bloc<TempleTimingEvent, TempleTimingState> {
  TempleTimingBloc() : super(TempleTimingInitial()) {
    on<TempleTimingEvent>((event, emit) {});
  }
}
