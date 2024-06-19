import 'package:flutter_bloc/flutter_bloc.dart';

part 'custom_scroll_state.dart';

class CustomScrollCubit extends Cubit<CustomScrollState> {
  CustomScrollCubit() : super(CustomScrollInitial());

  onScroll(bool canScrollDesc) {
    
    emit(CustomScrollLoaded(canScrollDesc));
  }
}
