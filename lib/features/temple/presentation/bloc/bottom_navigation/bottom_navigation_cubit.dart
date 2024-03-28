import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);

  changePage(int pageIndex) {
    emit(pageIndex);
  }
}
