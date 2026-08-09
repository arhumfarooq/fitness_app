import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Restrained typography scale for Fitness AI Design Language v1.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayMetric =>
      _inter(size: 32, lineHeight: 38, weight: FontWeight.w700);

  static TextStyle get headingLarge =>
      _inter(size: 28, lineHeight: 34, weight: FontWeight.w700);

  static TextStyle get headingMedium =>
      _inter(size: 22, lineHeight: 28, weight: FontWeight.w700);

  static TextStyle get title =>
      _inter(size: 17, lineHeight: 22, weight: FontWeight.w600);

  static TextStyle get body =>
      _inter(size: 15, lineHeight: 22, weight: FontWeight.w400);

  static TextStyle get bodySmall =>
      _inter(size: 14, lineHeight: 20, weight: FontWeight.w400);

  static TextStyle get label =>
      _inter(size: 14, lineHeight: 18, weight: FontWeight.w600);

  static TextStyle get caption =>
      _inter(size: 12, lineHeight: 16, weight: FontWeight.w500);

  static TextStyle _inter({
    required double size,
    required double lineHeight,
    required FontWeight weight,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      height: lineHeight / size,
      fontWeight: weight,
    );
  }

  // -------------------------------------------------------------------------
  // Legacy compatibility styles. Keep until inline screen styles are migrated.
  // -------------------------------------------------------------------------
  static TextStyle get h1 =>
      GoogleFonts.inter(fontSize: 32.sp, fontWeight: FontWeight.w800);
  static TextStyle get h2 =>
      GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w700);
  static TextStyle get h3 =>
      GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w600);
  static TextStyle get h4 =>
      GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle get bodyMed =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle get bodySm =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle get btn =>
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle get numLg =>
      GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.w700);
  static TextStyle get numMd =>
      GoogleFonts.inter(fontSize: 22.sp, fontWeight: FontWeight.w700);
}
