import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/exports.dart';

/// Reusable dark zinc textured header used across all screens
class DarkHeader extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const DarkHeader({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.fromLTRB(
            AppSizes.screenPad,
            AppSizes.headerPadTop,
            AppSizes.screenPad,
            AppSizes.xxl,
          ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.headerStart, AppColors.headerEnd],
        ),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/// Header with rounded bottom corners (used on Home, Profile)
class DarkHeaderRounded extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const DarkHeaderRounded({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return DarkHeader(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(32.r),
        bottomRight: Radius.circular(32.r),
      ),
      padding: padding,
      child: child,
    );
  }
}

/// Back button styled for dark header
class DarkBackButton extends StatelessWidget {
  const DarkBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.overlay10,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(color: AppColors.border20),
        ),
        child: Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: AppSizes.iconMd),
      ),
    );
  }
}
