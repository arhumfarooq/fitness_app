import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/presentation/theme/app_text_styles.dart' show AppTextStyles;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _weeklyData = [65.0, 78, 82, 71, 88, 75, 90];
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  static const _quickActions = [
    _QA(label: 'Workout', icon: Icons.fitness_center_rounded, route: AppRoutes.workouts, color: AppColors.primary),
    _QA(label: 'AI Coach', icon: Icons.chat_bubble_rounded, route: AppRoutes.aiCoach, color: Color(0xFF7C3AED)),
    _QA(label: 'Meals', icon: Icons.restaurant_rounded, route: AppRoutes.meals, color: Color(0xFFF97316)),
    _QA(label: 'Challenges', icon: Icons.track_changes_rounded, route: AppRoutes.challenges, color: Color(0xFFEAB308)),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<HomeViewModel>();

    return Scaffold(
      body: Column(
        children: [
          DarkHeaderRounded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.welcomePrefix,
                            style: TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
                        Text('Alex 👋',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.notifications),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.overlay10,                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                          border: Border.all(color: AppColors.border20),
                        ),
                        child: Icon(Icons.notifications_rounded,
                            color: Colors.white, size: AppSizes.iconLg),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(children: [
                  Icon(Icons.history_rounded, color: Colors.grey, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(AppStrings.lastSessionVal,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11.sp)),
                ]),
                SizedBox(height: 14.h),
                Container(
                  padding: EdgeInsets.all(AppSizes.cardPadMd),
                  decoration: BoxDecoration(
                    color: AppColors.overlay10,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                    border: Border.all(color: AppColors.border20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        ),
                        child: Icon(Icons.bolt_rounded,
                            color: Colors.white, size: AppSizes.iconLg),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.dailyStreak,
                              style: TextStyle(color: Colors.grey[300], fontSize: 12.sp)),
                          Text('12 Days 🔥',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                          border: Border.all(color: Colors.amber.withOpacity(0.3)),
                        ),
                        child: Text('Personal best!',
                            style: TextStyle(color: Colors.amber, fontSize: 11.sp)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  AppSizes.screenPad, AppSizes.lg, AppSizes.screenPad, 100),
              children: [
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _quickActions
                      .map((a) => _QuickActionTile(action: a))
                      .toList(),
                ),
                SizedBox(height: 20.h),

                Obx(() => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.9,
                      children: [
                        StatCard(
                          title: 'Steps',
                          value: '8,547',
                          subtitle: 'Steps / 10,000',
                          icon: Icons.directions_walk_rounded,
                          iconBg: const Color(0xFFF4F4F5),
                          iconColor: AppColors.primary,
                          progress: 0.85,
                          onTap: () => ToastHelper.show(context, 'Steps: 8,547 / 10,000',
                              description: '85% of goal — Keep going! 💪'),
                        ),
                        StatCard(
                          title: 'Calories',
                          value: '420',
                          subtitle: 'Calories / 600',
                          icon: Icons.local_fire_department_rounded,
                          iconBg: const Color(0xFFFFF7ED),
                          iconColor: AppColors.orange,
                          progress: 0.70,
                          onTap: () => ToastHelper.show(context, 'Calories: 420 / 600',
                              description: '70% of goal'),
                        ),
                        StatCard(
                          title: 'Water',
                          value: '${vm.waterCount.value}/8',
                          subtitle: 'Glasses · tap to log',
                          icon: Icons.water_drop_rounded,
                          iconBg: const Color(0xFFEFF6FF),
                          iconColor: AppColors.blue,
                          progress: vm.waterProgress,
                          onTap: () {
                            vm.logWater();
                            ToastHelper.show(
                              context,
                              '💧 Water logged!',
                              description: '${vm.waterCount.value} of 8 glasses today',
                              onUndo: vm.undoWater,
                            );
                          },
                        ),
                        StatCard(
                          title: 'Sleep',
                          value: '7.5h',
                          subtitle: 'Sleep / 8h',
                          icon: Icons.bedtime_rounded,
                          iconBg: const Color(0xFFF5F3FF),
                          iconColor: AppColors.purple,
                          progress: 0.94,
                          period: 'Last Night',
                          onTap: () => ToastHelper.show(context, 'Sleep: 7.5h / 8h',
                              description: '94% of goal — Great sleep! 🌙'),
                        ),
                      ],
                    )),
                SizedBox(height: 20.h),

                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.weeklyProgress, style: AppTextStyles.h4),
                              Text(AppStrings.weeklyTrend,
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 12)),
                            ],
                          ),
                          const Icon(Icons.trending_up_rounded,
                              color: AppColors.primary),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 160.h,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (v, meta) => Text(
                                    _days[v.toInt()],
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  interval: 1,
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: _weeklyData
                                    .asMap()
                                    .entries
                                    .map((e) =>
                                        FlSpot(e.key.toDouble(), e.value.toDouble()))
                                    .toList(),
                                isCurved: true,
                                color: AppColors.primary,
                                barWidth: 3,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: AppColors.primary.withOpacity(0.08),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () => context.push(AppRoutes.aiCoach),
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.cardPadXl),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.headerStart, Color(0xFF3F3F46)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: AppColors.overlay10,
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusMd),
                            border: Border.all(color: AppColors.border20),
                          ),
                          child: Icon(Icons.bolt_rounded,
                              color: Colors.white, size: AppSizes.iconLg),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.aiCoachTitle,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(height: 2.h),
                              Text(AppStrings.aiCoachLastMsg,
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 11.sp)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.radiusXl),
                          topRight: Radius.circular(AppSizes.radiusXl),
                        ),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=800',
                              height: 180.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Color(0xCC000000)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    _Pill(AppStrings.recommended, AppColors.primary),
                                    SizedBox(width: 8.w),
                                    _Pill('45 min',
                                        Colors.white.withOpacity(0.2)),
                                  ]),
                                  const SizedBox(height: 6),
                                  Text('Full Body HIIT',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSizes.cardPadLg),
                        child: Row(
                          children: [
                            _WorkoutStat('12', 'Exercises'),
                            SizedBox(width: 20.w),
                            _WorkoutStat('420', 'Calories'),
                            SizedBox(width: 20.w),
                            _WorkoutStat('Medium', 'Level'),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () => ToastHelper.success(
                                  context, AppStrings.workoutStarted,
                                  description: AppStrings.workoutStartedSub),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(0, 44.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w),
                              ),
                              child: const Text(AppStrings.startBtn),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const MobileNavBar(),
        ],
      ),
    );
  }
}

class _QA {
  final String label;
  final IconData icon;
  final String route;
  final Color color;
  const _QA(
      {required this.label,
      required this.icon,
      required this.route,
      required this.color});
}

class _QuickActionTile extends StatelessWidget {
  final _QA action;
  const _QuickActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(action.route),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: action.color,
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: action.color.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:
                Icon(action.icon, color: Colors.white, size: AppSizes.iconLg),
          ),
          SizedBox(height: 6.h),
          Text(action.label,
              style: TextStyle(
                  fontSize: 11.sp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.grey[600])),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color bg;
  const _Pill(this.label, this.bg);

  @override
  Widget build(BuildContext context) => Container(
        padding:
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        ),
        child: Text(label,
            style: TextStyle(color: Colors.white, fontSize: 11.sp)),
      );
}

class _WorkoutStat extends StatelessWidget {
  final String value;
  final String label;
  const _WorkoutStat(this.value, this.label);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10.sp)),
          Text(value, style: AppTextStyles.h4),
        ],
      );
}
