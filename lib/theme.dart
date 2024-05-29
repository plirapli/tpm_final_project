import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const bgColor = Color.fromARGB(255, 247, 248, 250);
  static const secondaryColor = Color.fromARGB(255, 229, 229, 229);
  static final Map<String, Color> errorColor = {
    "bg": const Color.fromARGB(255, 255, 225, 230),
    "normal": Colors.red.shade800
  };

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
            // fixedSize: const Size.fromHeight(42),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            )),
      ),
      useMaterial3: true,
    );
  }
}
