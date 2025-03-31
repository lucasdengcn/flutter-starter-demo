import 'package:flutter/material.dart';

class AppTheme {
  static const double _smallTextSize = 12.0;
  static const double _mediumTextSize = 14.0;
  static const double _largeTextSize = 16.0;
  static const double _headlineTextSize = 24.0;

  // Light Theme Colors
  static const Color _primaryColorLight = Color(0xFF2196F3);
  static const Color _secondaryColorLight = Color(0xFF03DAC6);
  static const Color _backgroundColorLight = Color(0xFFFFFFFF);
  static const Color _surfaceColorLight = Color(0xFFF5F5F5);
  static const Color _errorColorLight = Color(0xFFB00020);
  static const Color _onPrimaryColorLight = Color(0xFFFFFFFF);
  static const Color _onSecondaryColorLight = Color(0xFF000000);
  static const Color _onBackgroundColorLight = Color(0xFF000000);
  static const Color _onSurfaceColorLight = Color(0xFF000000);
  static const Color _onErrorColorLight = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color _primaryColorDark = Color(0xFF90CAF9);
  static const Color _secondaryColorDark = Color(0xFF03DAC6);
  static const Color _backgroundColorDark = Color(0xFF121212);
  static const Color _surfaceColorDark = Color(0xFF1E1E1E);
  static const Color _errorColorDark = Color(0xFFCF6679);
  static const Color _onPrimaryColorDark = Color(0xFF000000);
  static const Color _onSecondaryColorDark = Color(0xFF000000);
  static const Color _onBackgroundColorDark = Color(0xFFFFFFFF);
  static const Color _onSurfaceColorDark = Color(0xFFFFFFFF);
  static const Color _onErrorColorDark = Color(0xFF000000);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: _primaryColorLight,
        secondary: _secondaryColorLight,
        surface: _surfaceColorLight,
        error: _errorColorLight,
        onPrimary: _onPrimaryColorLight,
        onSecondary: _onSecondaryColorLight,
        onSurface: _onSurfaceColorLight,
        onError: _onErrorColorLight,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: _headlineTextSize,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(fontSize: _largeTextSize),
        bodyMedium: TextStyle(fontSize: _mediumTextSize),
        bodySmall: TextStyle(fontSize: _smallTextSize),
      ),
      appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        buttonColor: _primaryColorLight,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: _surfaceColorLight,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _primaryColorDark,
        secondary: _secondaryColorDark,
        surface: _surfaceColorDark,
        error: _errorColorDark,
        onPrimary: _onPrimaryColorDark,
        onSecondary: _onSecondaryColorDark,
        onSurface: _onSurfaceColorDark,
        onError: _onErrorColorDark,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: _headlineTextSize,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(fontSize: _largeTextSize),
        bodyMedium: TextStyle(fontSize: _mediumTextSize),
        bodySmall: TextStyle(fontSize: _smallTextSize),
      ),
      appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        buttonColor: _primaryColorDark,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: _surfaceColorDark,
      ),
    );
  }
}
