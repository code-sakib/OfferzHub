import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData currentTheme = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(),
      textTheme: GoogleFonts.lexendTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          decorationColor: Colors.white));
}
