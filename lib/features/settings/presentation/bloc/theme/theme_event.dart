part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class DarkModeEvent extends ThemeEvent {
  DarkModeEvent({required this.darkMode});
  final bool darkMode;
}

class LightModeEvent extends ThemeEvent {
  LightModeEvent({required this.index});
  final int index;
}
