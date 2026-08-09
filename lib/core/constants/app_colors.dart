import 'package:flutter/material.dart';

/// Semantic color tokens for Fitness AI Design Language v1.
///
/// New UI should prefer the semantic names at the top of this class. Legacy
/// aliases are retained at the bottom so screens can be migrated gradually.
class AppColors {
  AppColors._();

  // Core dark surfaces.
  static const background = Color(0xFF090A0B);
  static const surface1 = Color(0xFF111315);
  static const surface2 = Color(0xFF17191C);
  static const surface3 = Color(0xFF1D2023);

  // Borders and dividers.
  static const borderSubtle = Color(0xFF25292D);
  static const borderStrong = Color(0xFF2D3136);
  static const borderInteractive = Color(0xFF626B74);

  // Content colors.
  static const textPrimary = Color(0xFFF5F7F8);
  static const textSecondary = Color(0xFFAAB0B7);
  static const textMuted = Color(0xFF858C94);
  static const textDisabled = Color(0xFF626970);

  // Brand.
  static const brandPrimary = Color(0xFFC7F36B);
  static const onBrand = Color(0xFF10130A);

  // Fitness and status semantics.
  static const fitnessPositive = Color(0xFF73DC8C);
  static const energyOrange = Color(0xFFFF9F43);
  static const hydrationBlue = Color(0xFF62AEFF);
  static const aiPurple = Color(0xFFB09AFA);
  static const dangerRed = Color(0xFFFF7070);
  static const warningYellow = Color(0xFFF4C95D);

  // Tonal containers for compact semantic emphasis.
  static const activityContainer = Color(0xFF202A14);
  static const positiveContainer = Color(0xFF14291B);
  static const energyContainer = Color(0xFF2C1D12);
  static const hydrationContainer = Color(0xFF142232);
  static const aiContainer = Color(0xFF211A32);
  static const dangerContainer = Color(0xFF311718);
  static const warningContainer = Color(0xFF2A2312);

  static const overlayScrim = Color(0x99000000);

  // -------------------------------------------------------------------------
  // Legacy compatibility tokens. Keep until existing screens are migrated.
  // -------------------------------------------------------------------------
  static const primary = Color(0xFF18181B);
  static const primaryLight = Color(0xFF3F3F46);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const bgLight = Color(0xFFF9FAFB);
  static const bgDark = background;
  static const cardLight = white;
  static const cardDark = surface1;

  static const textLight = white;
  static const textDark = Color(0xFF18181B);

  static const borderLight = Color(0xFFE5E7EB);
  static const borderDark = borderSubtle;

  static const orange = energyOrange;
  static const blue = hydrationBlue;
  static const purple = aiPurple;
  static const yellow = warningYellow;
  static const red = dangerRed;
  static const green = fitnessPositive;
  static const pink = Color(0xFFEC4899);

  static const headerStart = Color(0xFF18181B);
  static const headerEnd = Color(0xFF27272A);

  static const success = fitnessPositive;
  static const error = dangerRed;
  static const warning = warningYellow;
  static const info = hydrationBlue;

  static const overlay10 = Color(0x1AFFFFFF);
  static const overlay20 = Color(0x33FFFFFF);
  static const border20 = Color(0x33FFFFFF);
}
