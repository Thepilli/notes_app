import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const jPrimaryColor = Color(0xFF3BC9BC);
  static const jSecondaryColor = Color(0xFF8BC8B1);
  static const jAccentColor = Color(0xFF001BFF);
  static const jCardBgColor = Color(0xffffdcbd);
  static const txtDark = Color(0xFF2A0B07);
  static const txtLight = Color(0xFFFFE1C5);
  static const bgDark = Colors.grey;

  static const backgroundColors = [
    Color(0xFFCCE5FF), // light blue
    Color(0xFFD7F9E9), // pale green
    Color(0xFFFFF8E1), // pale yellow
    Color(0xFFF5E6CC), // beige
    Color(0xFFFFD6D6), // light pink
    Color(0xFFE5E5E5), // light grey
    Color(0xFFFFF0F0), // pale pink
    Color(0xFFE6F9FF), // pale blue
    Color(0xFFD4EDDA), // mint green
    Color(0xFFFFF3CD), // pale orange
  ];
  static Color randomColor() {
    final random = Random();
    int randomIndex = random.nextInt(AppColors.backgroundColors.length);
    return AppColors.backgroundColors[randomIndex];
  }
}
