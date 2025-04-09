import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextTheme textTheme = const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontFamily: "Inter",
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontFamily: "Inter",
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontFamily: "Inter",
      fontSize: 14,
    ),
    bodyLarge:
        TextStyle(color: Colors.white, fontFamily: "Inter", fontSize: 16),
    bodyMedium:
        TextStyle(color: Colors.white, fontFamily: "Inter", fontSize: 14),
    bodySmall:
        TextStyle(color: Colors.white, fontFamily: "Inter", fontSize: 12),
    labelSmall: TextStyle(
      color: Colors.white,
      fontFamily: "Inter",
      fontSize: 12,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontFamily: "Inter",
      fontSize: 14,
    ),
    labelLarge:
        TextStyle(color: Colors.white, fontFamily: "Inter", fontSize: 16),
  );
}
