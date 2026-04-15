import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTypography {
  static TextStyle get displayHero => GoogleFonts.dmSans(
        fontSize: 80,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary.withValues(alpha: 0.08),
        letterSpacing: -4.5,
        height: 0.9,
      );

  static TextStyle get displayLarge => GoogleFonts.dmSans(
        fontSize: 52,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -2.8,
        height: 0.92,
      );

  static TextStyle get displayMedium => GoogleFonts.dmSans(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -1.6,
        height: 0.98,
      );

  static TextStyle get headingLarge => GoogleFonts.dmSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.8,
        height: 1.05,
      );

  static TextStyle get headingMedium => GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
        height: 1.15,
      );

  static TextStyle get headingSmall => GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.1,
        height: 1.2,
      );

  static TextStyle get bodyLarge => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.6,
        letterSpacing: -0.1,
      );

  static TextStyle get bodyMedium => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.55,
      );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
        height: 1.45,
      );

  static TextStyle get labelMedium => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 0.6,
        height: 1.2,
      );

  static TextStyle get labelSmall => GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: AppColors.textTertiary,
        letterSpacing: 1.2,
        height: 1.1,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textTertiary,
        letterSpacing: 0.2,
        height: 1.2,
      );

  static TextStyle get statNumber => GoogleFonts.dmSans(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -1.2,
        height: 1,
      );

  static TextStyle get buttonPrimary => GoogleFonts.dmSans(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: AppColors.background,
        letterSpacing: 0,
        height: 1,
      );
}