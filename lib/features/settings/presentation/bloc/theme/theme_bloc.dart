import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/common/class/local_storage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  Prefs pref = Prefs();
  ThemeBloc() : super(LightModeState(index: Prefs.getInt('theme_index') ?? 0)) {
    on<ThemeEvent>((ThemeEvent event, Emitter<ThemeState> emit) async {
      // if (event is DarkModeEvent) {
      //   emit(event.darkMode ? DarkModeState() : LightModeState(index: 0));
      // }
      if (event is LightModeEvent) {
        await Prefs.setInt('theme_index', event.index);
        emit(LightModeState(index: event.index));
      }
    });
  }
}
