import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores do Tema Escuro Elegante (Frisby Dark)
  static const Color darkBg = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF111111);
  static const Color darkCard = Color(0xFF1A1A1A);
  static const Color darkBorder = Color(0xFF333333);
  static const Color darkGold = Color(0xFFFFBF00);
  static const Color darkGoldHover = Color(0xFFE5AC00);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFF888888);

  // Cores do Tema Claro (Frisby Light)
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightPrimary = Color(0xFF4F46E5);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Status Colors
  static const Color approvedBgDark = Color(0xFF052C16);
  static const Color approvedTextDark = Color(0xFF4ADE80);
  static const Color approvedBorderDark = Color(0xFF166534);

  static const Color recoveryBgDark = Color(0xFF422006);
  static const Color recoveryTextDark = Color(0xFFFBBF24);
  static const Color recoveryBorderDark = Color(0xFFB45309);

  static const Color failedBgDark = Color(0xFF450A0A);
  static const Color failedTextDark = Color(0xFFF87171);
  static const Color failedBorderDark = Color(0xFF991B1B);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary: darkGold,
        onPrimary: Colors.black,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        outline: darkBorder,
      ),
      cardTheme: const CardTheme(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: darkBorder),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        foregroundColor: darkGold,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme.apply(
          bodyColor: darkTextPrimary,
          displayColor: darkTextPrimary,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        onPrimary: Colors.white,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        outline: lightBorder,
      ),
      cardTheme: const CardTheme(
        color: lightSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: lightBorder),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightPrimary,
        foregroundColor: Colors.white,
        elevation: 2,
        scrolledUnderElevation: 2,
        centerTitle: false,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme.apply(
          bodyColor: lightTextPrimary,
          displayColor: lightTextPrimary,
        ),
      ),
    );
  }
}
