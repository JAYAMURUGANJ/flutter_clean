import 'package:flutter/material.dart';

const TextTheme appTextTheme = TextTheme(
  displayLarge:
      TextStyle(fontSize: 57, fontWeight: FontWeight.w300, color: Colors.black),
  displayMedium:
      TextStyle(fontSize: 45, fontWeight: FontWeight.w400, color: Colors.black),
  displaySmall:
      TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: Colors.black),
  headlineLarge:
      TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.black),
  headlineMedium:
      TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.black),
  headlineSmall:
      TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
  titleLarge:
      TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
  titleMedium:
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
  titleSmall:
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
  bodyLarge: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
  bodyMedium: TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
  bodySmall: TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
  labelLarge:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
  labelMedium:
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
  labelSmall:
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white),
);

final Shader linearGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Colors.orange, Colors.yellow, Colors.red, Colors.black],
).createShader(
  const Rect.fromLTRB(500.0, 50.0, 200.0, 400.0),
);
// final Shader linearGradient_2 = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: gradient,
// ).createShader(Rect.fromCircle(
//   center: Offset(fontSize, -200),
//   radius: fontSize / 3,
// ));
