import 'package:flutter/material.dart';
import 'package:mnemosyne_learn/app/theme/theme_extension.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: LightPalette.primary,
        primaryContainer: LightPalette.primaryContainer,

        secondary: LightPalette.secondary,
        tertiary: LightPalette.tertiary,

        surface: LightPalette.surface,
        surfaceContainer: LightPalette.surfaceContainer,

        onSurface: LightPalette.onSurface,
        onPrimary: Colors.white,

        error: LightPalette.error,
      ),

      scaffoldBackgroundColor: LightPalette.background,

      textTheme: AppTextTheme.textTheme,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: DarkPalette.primary,
        primaryContainer: DarkPalette.primaryContainer,

        secondary: DarkPalette.secondary,
        tertiary: DarkPalette.tertiary,

        surface: DarkPalette.surface,
        surfaceContainer: DarkPalette.surfaceContainer,

        onSurface: DarkPalette.onSurface,
        onPrimary: Color(0xFF1000A9),

        error: DarkPalette.error,
      ),

      scaffoldBackgroundColor: DarkPalette.background,

      textTheme: AppTextTheme.textTheme,
    );
  }
}
