import 'package:flutter/material.dart';
import '../../../../core/exports.dart';

class PremiumBrandMark extends StatelessWidget {
  const PremiumBrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSizes.radiusExtraLarge),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandPrimary.withValues(alpha: 0.12),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.bolt_rounded,
          color: AppColors.brandPrimary,
          size: 36,
        ),
      ),
    );
  }
}
