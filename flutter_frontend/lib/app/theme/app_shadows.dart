import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const ambient = [
    BoxShadow(
      blurRadius: 40,
      spreadRadius: -10,
      offset: Offset(0, 20),
      color: Color(0x553F46FF),
    ),
  ];

  static const soft = [
    BoxShadow(
      blurRadius: 24,
      spreadRadius: -8,
      offset: Offset(0, 12),
      color: Colors.black38,
    ),
  ];
}