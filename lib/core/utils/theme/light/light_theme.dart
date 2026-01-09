import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _headerGreen = Color(0xFF16A34A);
  static const _bgLight = Color(0xFFF1F1E6);
  static const _darkBg = Color(0xFF111827);
  static const _darkCard = Color(0xFF1F2933);
  static const _darkInput = Color(0xFF111827);
  static const _darkText = Color(0xFFF9FAFB);
  static const _darkSubText = Color(0xFF9CA3AF);
  static const _accentGreen = Color(0xFF22C55E);

  static ThemeData light({required bool isArabic}) {
    final baseTextTheme = isArabic
        ? GoogleFonts.cairoTextTheme()
        : GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _bgLight,
      colorScheme: const ColorScheme.light(
        primary: _headerGreen,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _headerGreen,
        elevation: 0,
      ),
      textTheme: baseTextTheme.apply(
        bodyColor: _headerGreen,
        displayColor: _headerGreen,
      ),
    );
  }

  static ThemeData dark({required bool isArabic}) {
    final baseTextTheme = isArabic
        ? GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme)
        : GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: _darkBg,

      colorScheme: const ColorScheme.dark(
        primary: _headerGreen,
        secondary: _accentGreen,
        surface: _darkCard,
        onSurface: _darkText,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: _headerGreen,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: _darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.06)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkInput,
        hintStyle: const TextStyle(color: _darkSubText),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _accentGreen, width: 1.6),
        ),
      ),

      textTheme: baseTextTheme.apply(
        bodyColor: _darkText,
        displayColor: _darkText,
      ),

      dividerTheme: DividerThemeData(
        color: Colors.white.withOpacity(0.08),
        thickness: 1,
      ),

      iconTheme: const IconThemeData(color: _accentGreen),
    );
  }
}
