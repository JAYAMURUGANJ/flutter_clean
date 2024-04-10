import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temple_pooja_event.dart';
part 'temple_pooja_state.dart';

class TemplePoojaBloc extends Bloc<TemplePoojaEvent, TemplePoojaState> {
  TemplePoojaBloc() : super(TemplePoojaInitial()) {
    on<TemplePoojaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
