import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../../routes/app_router.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/exports.dart';
import '../../widgets/home/ai_insight_card.dart';
import '../../widgets/home/chart_card.dart';
import '../../widgets/home/compact_metric_tile.dart';
import '../../widgets/home/large_metric_card.dart';
import '../../widgets/home/workout_hero_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<double> _weeklyData = [65.0, 78.0, 82.0, 71.0, 88.0, 75.0, 90.0];
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final workout = WorkoutRepository.getHomeWorkouts().first;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                AppSizes.space4,
                AppSizes.screenPadding,
                AppSizes.space4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomePrefix,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSizes.space1),
                        Text(
                          'Alex',
                          style: AppTextStyles.headingMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSizes.space1),
                        Text(
                          'Mon, Aug 10',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Semantics(
                        button: true,
                        label: 'Show streak status',
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.space3,
                            vertical: AppSizes.space2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.activityContainer,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusPill,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_fire_department_rounded,
                                color: AppColors.brandPrimary,
                                size: AppSizes.iconMd,
                              ),
                              const SizedBox(width: AppSizes.space1),
                              Text(
                                '12 days',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      IconActionButton(
                        icon: Icons.notifications_rounded,
                        tooltip: 'Notifications',
                        semanticLabel: 'Open notifications',
                        onPressed: () => context.push(AppRoutes.notifications),
                      ),
                      const SizedBox(width: AppSizes.space1),
                      IconActionButton(
                        icon: Icons.person_rounded,
                        tooltip: 'Profile',
                        semanticLabel: 'Open profile',
                        onPressed: () => context.push(AppRoutes.profile),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.screenPadding,
                  AppSizes.space2,
                  AppSizes.screenPadding,
                  100,
                ),
                children: [
                  LargeMetricCard(
                    title: 'TODAY',
                    value: '8,432',
                    subtitle: 'steps',
                    detail: '84% of daily goal',
                    progress: 0.84,
                    accentColor: AppColors.brandPrimary,
                    trailing: Icon(
                      Icons.directions_walk_rounded,
                      color: AppColors.brandPrimary,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMedium,
                          ),
                          child: LinearProgressIndicator(
                            value: 0.84,
                            minHeight: 8,
                            backgroundColor: AppColors.borderSubtle,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.brandPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.space4),
                        Row(
                          children: [
                            Expanded(
                              child: _MetricPair(
                                label: 'Calories',
                                value: '612 kcal',
                                color: AppColors.energyOrange,
                              ),
                            ),
                            const SizedBox(width: AppSizes.space3),
                            Expanded(
                              child: _MetricPair(
                                label: 'Active',
                                value: '42 min',
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.space5),
                  Text(
                    "TODAY'S WORKOUT",
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.space3),
                  WorkoutHeroCard(
                    title: workout.name,
                    subtitle: '${workout.duration} · ${workout.difficulty}',
                    duration: workout.duration,
                    difficulty: workout.difficulty,
                    imageUrl: workout.imageUrl,
                    ctaLabel: AppStrings.startBtn,
                    onPressed: () {
                      ToastHelper.success(
                        context,
                        AppStrings.workoutStarted,
                        description: AppStrings.workoutStartedSub,
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.space5),
                  AiInsightCard(
                    title: 'AI COACH',
                    message:
                        'Keep the pace steady and prioritize recovery after today\'s session.',
                    actionLabel: 'Ask Coach',
                    onPressed: () => context.push(AppRoutes.aiCoach),
                  ),
                  const SizedBox(height: AppSizes.space5),
                  ChartCard(
                    title: 'WEEKLY ACTIVITY',
                    value: '7.8k avg steps',
                    caption: 'Steady trend across the week',
                    data: _weeklyData,
                    labels: _days,
                    accentColor: AppColors.brandPrimary,
                  ),
                  const SizedBox(height: AppSizes.space5),
                  Wrap(
                    spacing: AppSizes.space3,
                    runSpacing: AppSizes.space3,
                    children: [
                      SizedBox(
                        width: 0.48.sw,
                        child: CompactMetricTile(
                          label: 'Hydration',
                          value: '6/8',
                          detail: 'glasses today',
                          icon: Icons.water_drop_rounded,
                          iconColor: AppColors.hydrationBlue,
                          backgroundColor: AppColors.hydrationContainer,
                        ),
                      ),
                      SizedBox(
                        width: 0.48.sw,
                        child: CompactMetricTile(
                          label: 'Recovery',
                          value: '87%',
                          detail: 'ready to train',
                          icon: Icons.favorite_rounded,
                          iconColor: AppColors.aiPurple,
                          backgroundColor: AppColors.aiContainer,
                        ),
                      ),
                      SizedBox(
                        width: 0.48.sw,
                        child: CompactMetricTile(
                          label: 'Calories',
                          value: '612',
                          detail: 'burned today',
                          icon: Icons.local_fire_department_rounded,
                          iconColor: AppColors.energyOrange,
                          backgroundColor: AppColors.energyContainer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const MobileNavBar(),
          ],
        ),
      ),
    );
  }
}

class _MetricPair extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricPair({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space3),
      decoration: BoxDecoration(
        color: AppColors.surface3,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
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
          Text(value, style: AppTextStyles.title.copyWith(color: color)),
        ],
      ),
    );
  }
}
