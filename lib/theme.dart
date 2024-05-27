import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 70, 216, 189),
      primary: Colors.black,
      secondary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    useMaterial3: true,
  );
}
