import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  // Spacing
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 20.w;
  static double get xxl => 24.w;
  static double get xxxl => 32.w;

  // Border radius
  static double get radiusSm => 8.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;
  static double get radiusXl => 20.r;
  static double get radiusXxl => 24.r;
  static double get radiusFull => 100.r;

  // Icon sizes
  static double get iconSm => 16.sp;
  static double get iconMd => 20.sp;
  static double get iconLg => 24.sp;
  static double get iconXl => 32.sp;

  // Button height
  static double get btnSm => 36.h;
  static double get btnMd => 48.h;
  static double get btnLg => 56.h;

  // Card padding
  static double get cardPadSm => 12.w;
  static double get cardPadMd => 16.w;
  static double get cardPadLg => 20.w;
  static double get cardPadXl => 24.w;

  // Screen horizontal padding
  static double get screenPad => 20.w;

  // Bottom nav height
  static double get navHeight => 70.h;

  // Header padding top (safe area + extra)
  static double get headerPadTop => 52.h;

  // Max content width (mobile)
  static double get maxWidth => 480.w;
}
