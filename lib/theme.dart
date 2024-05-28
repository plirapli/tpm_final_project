import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const bg = Color.fromARGB(255, 247, 248, 250);

  static ThemeData myTheme() {
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
      textTheme: GoogleFonts.poppinsTextTheme(),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            fixedSize: Size.fromHeight(44),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
      useMaterial3: true,
    );
  }
}
