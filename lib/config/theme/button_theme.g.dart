import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButtonTheme = const ElevatedButtonThemeData(
    style: ButtonStyle(
  elevation: MaterialStatePropertyAll(15),
  textStyle: MaterialStatePropertyAll(
    TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
  ),
));
