part of 'selected_favorite_temples_cubit.dart';

class SelectedFavoriteTemplesState {
  const SelectedFavoriteTemplesState();
}

class SelectedFavoriteTemplesInitial extends SelectedFavoriteTemplesState {}

class FavoritesSelected extends SelectedFavoriteTemplesState {
  final List selectedList;
  FavoritesSelected(this.selectedList);
}
