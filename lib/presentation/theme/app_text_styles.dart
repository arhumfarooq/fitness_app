import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get h1 => GoogleFonts.inter(fontSize: 32.sp, fontWeight: FontWeight.w800);
  static TextStyle get h2 => GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w700);
  static TextStyle get h3 => GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w600);
  static TextStyle get h4 => GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle get body => GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400);
  static TextStyle get bodyMed => GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle get bodySm => GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle get caption => GoogleFonts.inter(fontSize: 11.sp, fontWeight: FontWeight.w400);
  static TextStyle get label => GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500);
  static TextStyle get btn => GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle get numLg => GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.w700);
  static TextStyle get numMd => GoogleFonts.inter(fontSize: 22.sp, fontWeight: FontWeight.w700);
}
