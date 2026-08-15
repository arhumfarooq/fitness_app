import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/presentation/theme/exports.dart';

class WorkoutHeroCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String difficulty;
  final String imageUrl;
  final String ctaLabel;
  final VoidCallback onPressed;

  const WorkoutHeroCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.difficulty,
    required this.imageUrl,
    required this.ctaLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSizes.radiusExtraLarge),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.background.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: AppSizes.space4,
                  right: AppSizes.space4,
                  bottom: AppSizes.space4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.headingMedium.copyWith(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.space5),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: AppSizes.space2,
                    runSpacing: AppSizes.space2,
                    children: [
                      _pill(
                        duration,
                        AppColors.activityContainer,
                        AppColors.brandPrimary,
                      ),
                      _pill(
                        difficulty,
                        AppColors.surface3,
                        AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.space3),
                FilledButton.tonalIcon(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brandPrimary,
                    foregroundColor: AppColors.onBrand,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.space4,
                      vertical: AppSizes.space3,
                    ),
                    minimumSize: const Size(0, AppSizes.minTouchTarget),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: Text(ctaLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space3,
        vertical: AppSizes.space2,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
      ),
      child: Text(text, style: AppTextStyles.caption.copyWith(color: fg)),
    );
  }
}
