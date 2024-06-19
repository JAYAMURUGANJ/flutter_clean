part of 'custom_scroll_cubit.dart';

class CustomScrollState {
  const CustomScrollState();
}

class CustomScrollInitial extends CustomScrollState {}

class CustomScrollLoaded extends CustomScrollState {
  final bool canScrollDesc;
  CustomScrollLoaded(this.canScrollDesc);
}
