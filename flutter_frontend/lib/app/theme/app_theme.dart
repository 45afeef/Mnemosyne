import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_theme.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      colorSchemeSeed: AppColors.primary,

      scaffoldBackgroundColor: AppColors.background,

      textTheme: AppTextThemes.textTheme,

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true);
  }
}