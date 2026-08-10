import 'package:flutter/material.dart';
import '../../../../core/exports.dart';
import '../../theme/app_text_styles.dart';

class CompactMetricTile extends StatelessWidget {
  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;

  const CompactMetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
    required this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space4),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.space2),
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.surface3,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: Icon(icon, color: iconColor, size: AppSizes.iconLg),
          ),
          const SizedBox(width: AppSizes.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSizes.space1),
                Text(
                  value,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.space1),
                Text(
                  detail,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
