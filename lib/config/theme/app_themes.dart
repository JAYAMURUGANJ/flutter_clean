import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';

import '/config/theme/button_theme.g.dart';

// ThemeData theme(String language) {
ThemeData theme() {
  return ThemeData(
      useMaterial3: true,
      //textTheme: appTextTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme(),
      textTheme: Locales.lang == "en"
          ? GoogleFonts.openSansTextTheme().copyWith(
              titleMedium: const TextStyle(fontSize: 18),
            )
          : GoogleFonts.notoSansTamilTextTheme()
              .copyWith(titleMedium: const TextStyle(fontSize: 18)));
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}
