import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/data/repositories/exports.dart';
import 'package:fitness_app/data/models/exports.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';
import 'package:fitness_app/routes/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _steps = 8432;

  @override
  Widget build(BuildContext context) {
    final workout = WorkoutRepository.getHomeWorkouts().first;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                AppSizes.space3,
                AppSizes.screenPadding,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: _Header(
                  onNotification: () => context.push(AppRoutes.notifications),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                AppSizes.space5,
                AppSizes.screenPadding,
                100,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _sectionTitle("TODAY'S SUMMARY"),
                  const SizedBox(height: AppSizes.space2),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          icon: Icons.directions_walk_rounded,
                          title: 'Steps',
                          value: _format(_steps),
                          goal: '10,000',
                          color: AppColors.fitnessPositive,
                          progress: _steps / 10000,
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      const Expanded(
                        child: _SummaryCard(
                          icon: Icons.local_fire_department_rounded,
                          title: 'Calories',
                          value: '1,250',
                          goal: '2,300',
                          color: AppColors.workoutCalories,
                          progress: .54,
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      const Expanded(
                        child: _SummaryCard(
                          icon: Icons.bedtime_rounded,
                          title: 'Sleep',
                          value: '7.2',
                          goal: '8 hrs',
                          color: AppColors.hydrationBlue,
                          progress: .9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.space5),
                  _sectionTitle("TODAY'S WORKOUT", trailing: 'View All'),
                  const SizedBox(height: AppSizes.space2),
                  _WorkoutCard(
                    workout: workout,
                    onStart: () =>
                        ToastHelper.success(context, 'Workout started!'),
                  ),
                  const SizedBox(height: AppSizes.space5),
                  _sectionTitle('WEEKLY ACTIVITY', trailing: 'This Week'),
                  const SizedBox(height: AppSizes.space2),
                  const _WeeklyChart(),
                  const SizedBox(height: AppSizes.space5),
                  _sectionTitle('QUICK ACTIONS'),
                  const SizedBox(height: AppSizes.space2),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.restaurant_rounded,
                          label: 'Meals / Scan Food',
                          color: AppColors.workoutCalories,
                          onTap: () => context.push(AppRoutes.meals),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.monitor_weight_outlined,
                          label: 'Sleep Tracker',
                          color: AppColors.aiPurple,
                          onTap: () => context.push(AppRoutes.sleep),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.water_drop_outlined,
                          label: 'Water Tracker',
                          color: AppColors.hydrationBlue,
                          onTap: () => context.push(AppRoutes.water),
                        ),
                      ),
                      const SizedBox(width: AppSizes.space2),
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.emoji_events_outlined,
                          label: 'Challenges',
                          color: AppColors.activityOrange,
                          onTap: () => context.push(AppRoutes.challenges),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.space4),
                  _PremiumBanner(
                    onPressed: () => context.push(AppRoutes.premium),
                  ),
                  const SizedBox(height: AppSizes.space5),
                  _sectionTitle('HEALTH & RECOVERY'),
                  const SizedBox(height: AppSizes.space2),
                  Row(
                    children: [
                      Expanded(
                        child: _HealthCard(
                          title: 'Hydration',
                          value: '6/8',
                          detail: 'glasses today',
                          icon: Icons.water_drop_rounded,
                          color: AppColors.hydrationBlue,
                        ),
                      ),
                      const SizedBox(width: AppSizes.space3),
                      Expanded(
                        child: _HealthCard(
                          title: 'Recovery',
                          value: '87%',
                          detail: 'ready to train',
                          icon: Icons.favorite_rounded,
                          color: AppColors.aiPurple,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SafeArea(top: false, child: MobileNavBar()),
    );
  }

  Widget _sectionTitle(String title, {String? trailing}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppTextStyles.label.copyWith(color: AppColors.textPrimary),
      ),
      if (trailing != null)
        Text(
          trailing,
          style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
        ),
    ],
  );
  String _format(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
}

class _Header extends StatelessWidget {
  final VoidCallback onNotification;
  const _Header({required this.onNotification});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, 👋',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              'Arhum',
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              "Let's make today amazing!",
              style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
      IconActionButton(
        icon: Icons.notifications_none_rounded,
        tooltip: 'Notifications',
        semanticLabel: 'Open notifications',
        onPressed: onNotification,
      ),
      const SizedBox(width: AppSizes.space2),
      const CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.surface3,
        child: Icon(Icons.person_rounded, color: AppColors.textPrimary),
      ),
    ],
  );
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title, value, goal;
  final Color color;
  final double progress;
  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.goal,
    required this.color,
    required this.progress,
  });
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 2),
        FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: AppTextStyles.title.copyWith(color: AppColors.textPrimary),
          ),
        ),
        Text(
          '/ $goal',
          style: AppTextStyles.caption.copyWith(
            color: color ?? AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1),
            minHeight: 3,
            color: color,
            backgroundColor: AppColors.surface3,
          ),
        ),
      ],
    ),
  );
}

class _WorkoutCard extends StatelessWidget {
  final HomeWorkout workout;
  final VoidCallback onStart;
  const _WorkoutCard({required this.workout, required this.onStart});
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.radiusLarge),
            ),
            child: SizedBox(
              height: 118,
              width: double.infinity,
              child: Image.network(
                workout.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surface3,
                  child: const Icon(Icons.fitness_center_rounded, size: 50),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Push Day',
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Chest · Shoulders · Triceps',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${workout.duration} · ${workout.difficulty}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onStart,
                    child: const Text('Start', style: TextStyle(fontSize: 12)),
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

class _WeeklyChart extends StatelessWidget {
  const _WeeklyChart();
  @override
  Widget build(BuildContext context) {
    const values = [40.0, 70.0, 56.0, 86.0, 64.0, 78.0, 91.0];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              const _Legend(color: AppColors.fitnessPositive, label: 'Steps'),
              const SizedBox(width: 12),
              const _Legend(
                color: AppColors.workoutCalories,
                label: 'Calories',
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                values.length,
                (i) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 6,
                          height: values[i],
                          decoration: BoxDecoration(
                            color: AppColors.fitnessPositive,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 3),
                        Container(
                          width: 6,
                          height: values[(i + 2) % values.length] * .8,
                          decoration: BoxDecoration(
                            color: AppColors.workoutCalories,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      days[i],
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 4),
      Text(
        label,
        style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
      ),
    ],
  );
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 94,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.space3,
          horizontal: 3,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _PremiumBanner extends StatelessWidget {
  final VoidCallback onPressed;
  const _PremiumBanner({required this.onPressed});
  @override
  Widget build(BuildContext context) => AppCard(
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
          child: const Icon(
            Icons.workspace_premium_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: AppSizes.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Go Premium', style: AppTextStyles.label),
              Text(
                'Remove ads, unlock premium workouts',
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
        TextButton(onPressed: onPressed, child: const Text('Upgrade')),
      ],
    ),
  );
}

class _HealthCard extends StatelessWidget {
  final String title, value, detail;
  final IconData icon;
  final Color color;
  const _HealthCard({
    required this.title,
    required this.value,
    required this.detail,
    required this.icon,
    required this.color,
  });
  @override
  Widget build(BuildContext context) => AppCard(
    child: Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: AppSizes.space2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(value, style: AppTextStyles.title),
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
