import 'package:flutter/material.dart';

class AppTextTheme {
  static const textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 1.1,
      letterSpacing: -0.8,
    ),

    headlineMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 30,
      fontWeight: FontWeight.w600,
      height: 1.2,
    ),

    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      height: 1.6,
    ),

    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      height: 1.5,
    ),

    labelSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
    ),
  );
}