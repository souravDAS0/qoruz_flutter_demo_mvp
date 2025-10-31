import 'package:flutter/material.dart';

/// App color constants based on Qoruz design system
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryOrange = Color(0xFFFF6435);
  static const Color darkPurple = Color(0xFF3E00A9);
  static const Color white = Color(0xFFFFFFFF);

  // Accent Colors
  static const Color teal = Color(0xFF2ACC83);
  static const Color blue = Color(0xFF00B2EA);
  static const Color purple = Color(0xFF8D4AFF);
  static const Color lightPurple = Color(0xFFCB36FF);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textTertiary = Color(0xFF999999);

  // Background Colors
  static const Color backgroundMain = Color(0xFFFFFFFF);
  static const Color backgroundCard = Color(0xFFFAFAFA);
  static const Color backgroundGrey = Color(0xFFF5F5F5);

  // Border & Divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Status Colors
  static const Color success = Color(0xFF2ACC83);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF00B2EA);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [darkPurple, lightPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
