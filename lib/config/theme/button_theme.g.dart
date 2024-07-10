import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButtonTheme = const ElevatedButtonThemeData(
    style: ButtonStyle(
  elevation: WidgetStatePropertyAll(15),
  textStyle: WidgetStatePropertyAll(
    TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
  ),
));
