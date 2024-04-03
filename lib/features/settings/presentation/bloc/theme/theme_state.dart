part of 'theme_bloc.dart';

abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class DarkModeState extends ThemeState {}

class LightModeState extends ThemeState {
  LightModeState({required this.index});
  final int index;
}
