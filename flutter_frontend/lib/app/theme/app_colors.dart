import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const primary = Color(0xFFC0C1FF);
  static const primaryContainer = Color(0xFF8083FF);

  static const secondary = Color(0xFF4EDEA3);
  static const tertiary = Color(0xFFFFB783);

  // Background
  static const background = Color(0xFF051424);

  static const surface = Color(0xFF051424);
  static const surfaceDim = Color(0xFF051424);
  static const surfaceBright = Color(0xFF2C3A4C);

  static const surfaceLowest = Color(0xFF010F1F);
  static const surfaceLow = Color(0xFF0D1C2D);
  static const surfaceContainer = Color(0xFF122131);
  static const surfaceHigh = Color(0xFF1C2B3C);
  static const surfaceHighest = Color(0xFF273647);

  // Text

  static const onBackground = Color(0xFFD4E4FA);
  static const onSurface = Color(0xFFD4E4FA);
  static const onSurfaceVariant = Color(0xFFC7C4D7);

  // Outline

  static const outline = Color(0xFF908FA0);
  static const outlineVariant = Color(0xFF464554);

  // Semantic

  static const error = Color(0xFFFFB4AB);
  static const success = Color(0xFF7FCB89);

  static const warning = Color(0xFFFFD166);

  static const info = primary;
}

class DarkPalette {
  static const primary = Color(0xFFC0C1FF);
  static const primaryContainer = Color(0xFF8083FF);

  static const secondary = Color(0xFF4EDEA3);
  static const tertiary = Color(0xFFFFB783);

  static const background = Color(0xFF051424);

  static const surface = Color(0xFF051424);
  static const surfaceContainer = Color(0xFF122131);

  static const onSurface = Color(0xFFD4E4FA);
  static const onBackground = Color(0xFFD4E4FA);

  static const outline = Color(0xFF908FA0);

  static const error = Color(0xFFFFB4AB);

  static const success = Color(0xFF7FCB89);
  static const warning = Color(0xFFFFD166);
}

class LightPalette {
  static const primary = Color(0xFF4A55E5);
  static const primaryContainer = Color(0xFFDDE1FF);

  static const secondary = Color(0xFF007A55);
  static const tertiary = Color(0xFFC46A1B);

  static const background = Color(0xFFF8FAFC);

  static const surface = Colors.white;
  static const surfaceContainer = Color(0xFFF0F4F8);

  static const onSurface = Color(0xFF1A1C1E);
  static const onBackground = Color(0xFF1A1C1E);

  static const outline = Color(0xFF767680);

  static const error = Color(0xFFBA1A1A);

  static const success = Color(0xFF1B7F3C);
  static const warning = Color(0xFF9A5A00);
}

// | Token             | Dark      | Light     |
// | ----------------- | --------- | --------- |
// | Background        | `#051424` | `#F8FAFC` |
// | Surface           | `#051424` | `#FFFFFF` |
// | Surface Container | `#122131` | `#F0F4F8` |
// | Primary           | `#C0C1FF` | `#4A55E5` |
// | Primary Container | `#8083FF` | `#DDE1FF` |
// | Secondary         | `#4EDEA3` | `#007A55` |
// | Tertiary          | `#FFB783` | `#C46A1B` |
// | Text              | `#D4E4FA` | `#1A1C1E` |
// | Outline           | `#908FA0` | `#767680` |
// | Error             | `#FFB4AB` | `#BA1A1A` |
// | Success           | `#7FCB89` | `#1B7F3C` |
// | Warning           | `#FFD166` | `#9A5A00` |
