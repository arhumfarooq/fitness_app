import 'package:flutter/material.dart';

/// Semantic GYMORA AI color tokens.
///
/// The light palette is the product default. Dark tokens remain available for
/// the existing theme toggle and for gradual screen migration.
class AppColors {
  AppColors._();

  // GYMORA AI light foundation.
  static const background = Color(0xFFFAFAFC);
  static const surface1 = Color(0xFFFFFFFF);
  static const surface2 = Color(0xFFFFFFFF);
  static const surface3 = Color(0xFFF4F3F8);
  static const borderSubtle = Color(0xFFECECF1);
  static const borderStrong = Color(0xFFDFDFE8);
  static const borderInteractive = Color(0xFF92929D);
  static const textPrimary = Color(0xFF17151D);
  static const textSecondary = Color(0xFF92929D);
  static const textMuted = Color(0xFFB0B0BA);
  static const textDisabled = Color(0xFFC8C8D0);

  // Primary GYMORA brand.
  static const brandPrimary = Color(0xFF17151D);
  static const onBrand = Color(0xFFFFFFFF);

  // Fitness semantic accents.
  static const workoutCalories = Color(0xFFFF6B6B);
  static const activityOrange = Color(0xFFFFAA4C);
  static const hydrationRecovery = Color(0xFF6196FF);
  static const fitnessPositive = Color(0xFF45B878);
  static const aiPurple = Color(0xFF7B61FF);
  static const dangerRed = Color(0xFFFF6B6B);
  static const warningYellow = Color(0xFFFFAA4C);
  static const energyOrange = workoutCalories;
  static const hydrationBlue = hydrationRecovery;

  // Light tonal containers.
  static const activityContainer = Color(0xFFFFF1E2);
  static const positiveContainer = Color(0xFFE8F8EF);
  static const energyContainer = Color(0xFFFFE9E9);
  static const hydrationContainer = Color(0xFFEAF1FF);
  static const aiContainer = Color(0xFFF0ECFF);
  static const dangerContainer = Color(0xFFFFE9E9);
  static const warningContainer = Color(0xFFFFF1E2);
  static const overlayScrim = Color(0x66000000);

  // Dark fallback palette used by AppTheme.dark.
  static const darkBackground = Color(0xFF090A0B);
  static const darkSurface1 = Color(0xFF111315);
  static const darkSurface2 = Color(0xFF17191C);
  static const darkSurface3 = Color(0xFF1D2023);
  static const darkBorderSubtle = Color(0xFF25292D);
  static const darkBorderStrong = Color(0xFF2D3136);
  static const darkBorderInteractive = Color(0xFF626B74);
  static const darkTextPrimary = Color(0xFFF5F7F8);
  static const darkTextSecondary = Color(0xFFAAB0B7);
  static const darkTextMuted = Color(0xFF858C94);
  static const darkTextDisabled = Color(0xFF626970);
  static const darkBrandPrimary = Color(0xFFC7F36B);
  static const darkOnBrand = Color(0xFF10130A);
  static const darkFitnessPositive = Color(0xFF73DC8C);
  static const darkAiPurple = Color(0xFFB09AFA);
  static const darkHydrationBlue = Color(0xFF62AEFF);
  static const darkDangerRed = Color(0xFFFF7070);
  static const darkWarningYellow = Color(0xFFF4C95D);
  static const darkActivityContainer = Color(0xFF202A14);
  static const darkPositiveContainer = Color(0xFF14291B);
  static const darkEnergyContainer = Color(0xFF2C1D12);
  static const darkHydrationContainer = Color(0xFF142232);
  static const darkAiContainer = Color(0xFF211A32);
  static const darkDangerContainer = Color(0xFF311718);
  static const darkWarningContainer = Color(0xFF2A2312);

  // Legacy names retained while individual screens are migrated.
  static const primary = brandPrimary;
  static const primaryLight = Color(0xFF373340);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const bgLight = background;
  static const bgDark = darkBackground;
  static const cardLight = surface1;
  static const cardDark = darkSurface1;
  static const textLight = white;
  static const textDark = textPrimary;
  static const borderLight = borderSubtle;
  static const borderDark = darkBorderSubtle;
  static const orange = workoutCalories;
  static const blue = hydrationRecovery;
  static const purple = aiPurple;
  static const yellow = activityOrange;
  static const red = dangerRed;
  static const green = fitnessPositive;
  static const pink = Color(0xFFE76F9A);
  static const headerStart = brandPrimary;
  static const headerEnd = Color(0xFF2A2634);
  static const success = fitnessPositive;
  static const error = dangerRed;
  static const warning = warningYellow;
  static const info = hydrationRecovery;
  static const overlay10 = Color(0x1AFFFFFF);
  static const overlay20 = Color(0x33FFFFFF);
  static const border20 = Color(0x33FFFFFF);
}
