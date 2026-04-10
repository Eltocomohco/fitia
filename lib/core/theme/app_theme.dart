import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Configuración global de tema para la aplicación.
abstract final class AppTheme {
  /// Color primario de marca.
  static const Color primary = Color(0xFFE5C043);

  /// Fondo principal de la app.
  static const Color background = Color(0xFFFCFBF8);

  /// Superficie para tarjetas y contenedores.
  static const Color surface = Color(0xFFF3EFE6);

  /// Color principal para texto e iconografía.
  static const Color onBase = Color(0xFF2A3441);

  /// Color de error global.
  static const Color error = Color(0xFFD96C5B);

  /// Fondo principal de la app en modo oscuro.
  static const Color darkBackground = Color(0xFF121212);

  /// Superficie para tarjetas y contenedores en modo oscuro.
  static const Color darkSurface = Color(0xFF1E1E1E);

  /// `ThemeData` listo para usarse en `MaterialApp.theme`.
  static ThemeData get light {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: primary,
          onPrimary: onBase,
          surface: surface,
          onSurface: onBase,
          error: error,
          onError: Colors.white,
        );

    final baseTextTheme = ThemeData.light(useMaterial3: true).textTheme;
    final textTheme = GoogleFonts.poppinsTextTheme(
      baseTextTheme,
    ).apply(bodyColor: onBase, displayColor: onBase);

    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: onBase,
        iconTheme: const IconThemeData(color: onBase),
        titleTextStyle: TextStyle(
          color: onBase,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onBase,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// `ThemeData` para reaccionar al modo oscuro del sistema.
  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark().copyWith(
      primary: primary,
      onPrimary: Colors.black,
      surface: darkSurface,
      onSurface: Colors.white,
      error: error,
      onError: Colors.white,
    );

    final baseTextTheme = ThemeData.dark(useMaterial3: true).textTheme;
    final textTheme = GoogleFonts.poppinsTextTheme(
      baseTextTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white);

    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkBackground,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
