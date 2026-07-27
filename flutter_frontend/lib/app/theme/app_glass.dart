import 'package:flutter/material.dart';

class AppGlass {
  AppGlass._();

  static final decoration = BoxDecoration(
    color: Colors.white.withOpacity(.06),
    border: Border.all(
      color: Colors.white10,
    ),
    borderRadius: BorderRadius.circular(24),
  );
}