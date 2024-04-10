import 'package:flutter_bloc/flutter_bloc.dart';

part 'temple_pooja_event.dart';
part 'temple_pooja_state.dart';

class TemplePoojaBloc extends Bloc<TemplePoojaEvent, TemplePoojaState> {
  TemplePoojaBloc() : super(TemplePoojaInitial()) {
    on<TemplePoojaEvent>((event, emit) {});
  }
}
