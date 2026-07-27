import 'package:flutter/material.dart';
import 'package:mnemosyne_learn/app/theme/theme_extension.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,

        surface: AppColors.surface,
        surfaceContainer: AppColors.surfaceContainer,

        onSurface: AppColors.onSurface,
        onPrimary: Color(0xFF1000A9),

        error: AppColors.error,
      ),

      scaffoldBackgroundColor: AppColors.background,

      textTheme: AppTextTheme.textTheme,

      extensions: const [
        LearningColors(
          activeRecall: Color(0xFF6366F1),
          spacedRepetition: Color(0xFF4338CA),
          interleavedPractice: Color(0xFF64748B),
        ),
      ],
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true);
  }
}
