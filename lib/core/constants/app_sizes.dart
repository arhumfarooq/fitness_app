import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Layout and control tokens for Fitness AI Design Language v1.
class AppSizes {
  AppSizes._();

  // New semantic spacing scale (logical pixels).
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 20;
  static const double space6 = 24;
  static const double space7 = 32;

  // Semantic layout aliases.
  static const double screenPadding = space5;
  static const double cardPadding = space4;
  static const double sectionSpacing = space6;
  static const double majorSectionSpacing = space7;
  static const double cardGap = space4;

  // Radius scale.
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusExtraLarge = 20;
  static const double radiusPill = 999;

  // Controls and navigation.
  static const double minTouchTarget = 48;
  static const double buttonHeight = 52;
  static const double fieldHeight = 52;
  static const double bottomNavHeight = 72;
  static const double appHeaderHeight = 64;

  // -------------------------------------------------------------------------
  // Legacy responsive aliases. Keep until existing screens are migrated.
  // -------------------------------------------------------------------------
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 20.w;
  static double get xxl => 24.w;
  static double get xxxl => 32.w;

  static double get radiusSm => 8.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;
  static double get radiusXl => 20.r;
  static double get radiusXxl => 24.r;
  static double get radiusFull => 100.r;

  static double get iconSm => 16.sp;
  static double get iconMd => 20.sp;
  static double get iconLg => 24.sp;
  static double get iconXl => 32.sp;

  static double get btnSm => 36.h;
  static double get btnMd => 48.h;
  static double get btnLg => 56.h;

  static double get cardPadSm => 12.w;
  static double get cardPadMd => 16.w;
  static double get cardPadLg => 20.w;
  static double get cardPadXl => 24.w;

  static double get screenPad => 20.w;
  static double get navHeight => 70.h;
  static double get headerPadTop => 52.h;
  static double get maxWidth => 480.w;
}
