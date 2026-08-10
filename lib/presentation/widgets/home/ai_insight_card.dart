import 'package:flutter/material.dart';
import '../../../../core/exports.dart';
import '../../theme/app_text_styles.dart';

class AiInsightCard extends StatelessWidget {
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onPressed;

  const AiInsightCard({
    super.key,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space5),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSizes.radiusExtraLarge),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.space2),
            decoration: BoxDecoration(
              color: AppColors.aiContainer,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.aiPurple,
              size: AppSizes.iconLg,
            ),
          ),
          const SizedBox(width: AppSizes.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.space1),
                Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.space3),
          FilledButton.tonal(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.aiContainer,
              foregroundColor: AppColors.aiPurple,
              minimumSize: const Size(0, AppSizes.minTouchTarget),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.space4,
                vertical: AppSizes.space2,
              ),
            ),
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}
