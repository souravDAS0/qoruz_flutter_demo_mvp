import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App text styles based on Qoruz design system
class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle h1 = GoogleFonts.rethinkSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle h2 = GoogleFonts.rethinkSans(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle h3 = GoogleFonts.rethinkSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle h4 = GoogleFonts.rethinkSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Text
  static TextStyle bodyLarge = GoogleFonts.rethinkSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.rethinkSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.rethinkSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.5,
  );

  // Button Text
  static TextStyle button = GoogleFonts.rethinkSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Caption
  static TextStyle caption = GoogleFonts.rethinkSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.3,
  );

  // Label
  static TextStyle label = GoogleFonts.rethinkSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Overline
  static TextStyle overline = GoogleFonts.rethinkSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textTertiary,
    letterSpacing: 1.5,
    height: 1.5,
  );
}
