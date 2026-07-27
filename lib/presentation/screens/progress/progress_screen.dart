import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/exports.dart';
import '../../theme/exports.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  static const _tabs = ['Weight', 'Workouts', 'Body'];

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ProgressViewModel>();

    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Row(
              children: [
                const DarkBackButton(),
                const SizedBox(width: 14),
                Text(AppStrings.yourProgress,
                    style: AppTextStyles.h3.copyWith(color: Colors.white)),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  AppSizes.screenPad, AppSizes.lg, AppSizes.screenPad, 100),
              children: [
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.cardPadLg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.headerStart, Color(0xFF3F3F46)],
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(Icons.trending_down_rounded,
                                color: Colors.white, size: AppSizes.iconMd),
                            const SizedBox(width: 6),
                            Text('Weight Lost',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12)),
                          ]),
                          const SizedBox(height: 8),
                          const Text('2.5 kg',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800)),
                          Text('In 6 weeks',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.cardPadLg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6D28D9), Color(0xFF7C3AED)],
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(Icons.calendar_today_rounded,
                                color: Colors.white, size: AppSizes.iconMd),
                            const SizedBox(width: 6),
                            Text('Workout Days',
                                style: TextStyle(
                                    color: Colors.purple[200], fontSize: 12)),
                          ]),
                          const SizedBox(height: 8),
                          const Text('42',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800)),
                          Text('This month',
                              style: TextStyle(
                                  color: Colors.purple[200], fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 20),

                Obx(() => Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.cardDark
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                        border: Border.all(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? AppColors.borderDark
                                : AppColors.borderLight),
                      ),
                      child: Row(
                        children: _tabs.asMap().entries.map((e) {
                          final isActive = e.key == vm.tabIndex.value;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => vm.setTab(e.key),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.radiusMd),
                                ),
                                child: Center(
                                  child: Text(e.value,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: isActive
                                              ? Colors.white
                                              : Colors.grey)),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )),
                const SizedBox(height: 16),

                Obx(() {
                  if (vm.tabIndex.value == 0) return _WeightTab(vm: vm);
                  if (vm.tabIndex.value == 1) return _WorkoutTab(vm: vm);
                  return const _BodyTab();
                }),
              ],
            ),
          ),
          const MobileNavBar(),
        ],
      ),
    );
  }
}

class _WeightTab extends StatelessWidget {
  final ProgressViewModel vm;
  const _WeightTab({required this.vm});

  @override
  Widget build(BuildContext context) {
    final spots = vm.weightData
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), (e.value['weight'] as double)))
        .toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.weightTracking, style: AppTextStyles.h4),
          Text(AppStrings.last6Weeks,
              style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(LineChartData(
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              minY: 80,
              maxY: 86,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (v, m) => Text(
                      vm.weightData[v.toInt()]['week'].toString(),
                      style:
                          const TextStyle(fontSize: 10, color: Colors.grey),
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
                  spots: spots,
                  isCurved: true,
                  color: AppColors.primary,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.1)),
                ),
              ],
            )),
          ),
          const Divider(height: 32),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _StatsItem('Current', '82.5 kg'),
            _StatsItem('Goal', '75 kg'),
            _StatsItem('To Go', '7.5 kg', highlight: true),
          ]),
        ],
      ),
    );
  }
}

class _WorkoutTab extends StatelessWidget {
  final ProgressViewModel vm;
  const _WorkoutTab({required this.vm});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.weeklyActivity, style: AppTextStyles.h4),
          Text('Total: 315 minutes',
              style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(BarChartData(
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (v, m) => Text(
                      vm.workoutData[v.toInt()]['day'].toString(),
                      style:
                          const TextStyle(fontSize: 10, color: Colors.grey),
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
              barGroups: vm.workoutData.asMap().entries.map((e) {
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: (e.value['minutes'] as int).toDouble(),
                      color: AppColors.primary,
                      width: 18,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                  ],
                );
              }).toList(),
            )),
          ),
          const Divider(height: 32),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _StatsItem('This Week', '7 days'),
            _StatsItem('This Month', '26 days'),
            _StatsItem('Streak', '12 days', highlight: true),
          ]),
        ],
      ),
    );
  }
}

class _BodyTab extends StatelessWidget {
  const _BodyTab();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.bodyMeasurements, style: AppTextStyles.h4),
          Text('Track your transformation',
              style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          const SizedBox(height: 16),
          _BodyMetric('BMI', '24.8', 0.65, 'Normal', AppColors.primary),
          const SizedBox(height: 12),
          _BodyMetric('Body Fat', '18.5%', 0.70, 'Good', AppColors.blue),
          const SizedBox(height: 12),
          _BodyMetric('Muscle Mass', '68 kg', 0.82, '+2kg', AppColors.purple),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _MeasureChip('Chest', '98 cm'),
              _MeasureChip('Waist', '82 cm'),
              _MeasureChip('Arms', '35 cm'),
              _MeasureChip('Thighs', '58 cm'),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyMetric extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final String tag;
  final Color color;
  const _BodyMetric(this.label, this.value, this.progress, this.tag, this.color);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(label, style: const TextStyle(fontSize: 14)),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 16)),
          ]),
          const SizedBox(height: 6),
          Row(children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(tag, style: TextStyle(fontSize: 11, color: color)),
          ]),
        ],
      );
}

class _MeasureChip extends StatelessWidget {
  final String label;
  final String value;
  const _MeasureChip(this.label, this.value);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1F2937)
              : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: TextStyle(color: Colors.grey[500], fontSize: 10)),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 16)),
          ],
        ),
      );
}

class _StatsItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  const _StatsItem(this.label, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) => Column(children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: highlight ? AppColors.primary : null)),
      ]);
}
