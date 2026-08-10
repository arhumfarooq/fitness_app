import 'package:flutter/material.dart';
import '../../../../core/exports.dart';
import '../../theme/app_text_styles.dart';

class LargeMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String detail;
  final double progress;
  final Color accentColor;
  final Widget? trailing;
  final Widget? child;

  const LargeMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.detail,
    required this.progress,
    required this.accentColor,
    this.trailing,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space6),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSizes.radiusExtraLarge),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: AppSizes.space4),
          Text(
            value,
            style: AppTextStyles.displayMetric.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.space1),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.space4),
          if (child != null) child! else _buildProgressBar(),
          const SizedBox(height: AppSizes.space3),
          Text(
            detail,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: AppColors.borderSubtle,
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
          ),
        ),
        const SizedBox(height: AppSizes.space2),
        Text(
          '${(progress * 100).round()}% of daily goal',
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
