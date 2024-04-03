import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_clean_architecture/config/theme/button_theme.g.dart';
import 'package:news_app_clean_architecture/config/theme/text_theme.g.dart';

// ThemeData theme(String language) {
ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    // textTheme: appTextTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: GoogleFonts.exo2TextTheme(),
    //textTheme: GoogleFonts.tiroTamilTextTheme(),
  );
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
