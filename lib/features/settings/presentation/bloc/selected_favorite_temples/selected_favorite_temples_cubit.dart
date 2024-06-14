import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_favorite_temples_state.dart';

class SelectedFavoriteTemplesCubit extends Cubit<SelectedFavoriteTemplesState> {
  SelectedFavoriteTemplesCubit() : super(SelectedFavoriteTemplesInitial());

  onSelectFavorites(List selectedList, int index) {
    if (selectedList.contains(index)) {
      selectedList.remove(index);
    } else {
      selectedList.add(index);
    }
    emit(FavoritesSelected(selectedList));
  }
}
