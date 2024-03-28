import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);

  changePage(int pageIndex) {
    emit(pageIndex);
  }
}
