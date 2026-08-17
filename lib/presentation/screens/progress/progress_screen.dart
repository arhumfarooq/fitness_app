import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/presentation/screens/viewmodels/exports.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  static const _tabs = ['Weight', 'Workouts', 'Body Stats'];

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ProgressViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                AppSizes.space2,
                AppSizes.screenPadding,
                AppSizes.space3,
              ),
              child: Obx(
                () => _SegmentedTabs(
                  labels: _tabs,
                  selected: vm.tabIndex.value,
                  onChanged: vm.setTab,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final content = vm.tabIndex.value == 0
                    ? const _WeightProgressContent()
                    : vm.tabIndex.value == 1
                    ? _WorkoutProgressContent(vm: vm)
                    : const _BodySummaryContent();
                return ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.screenPadding,
                    0,
                    AppSizes.screenPadding,
                    100,
                  ),
                  children: [content],
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SafeArea(top: false, child: MobileNavBar()),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final List<String> labels;
  final int selected;
  final ValueChanged<int> onChanged;
  const _SegmentedTabs({
    required this.labels,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.surface3,
      borderRadius: BorderRadius.circular(AppSizes.radiusPill),
    ),
    child: Row(
      children: List.generate(
        labels.length,
        (i) => Expanded(
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: selected == i
                    ? AppColors.brandPrimary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              ),
              child: Text(
                labels[i],
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: selected == i
                      ? AppColors.onBrand
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _WeightProgressContent extends StatelessWidget {
  const _WeightProgressContent();
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight Progress', style: AppTextStyles.title),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface3,
                    borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                  ),
                  child: Text('80% of goal', style: AppTextStyles.caption),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.space3),
            SizedBox(height: 220, child: LineChart(_weightChartData())),
            const SizedBox(height: AppSizes.space3),
            const _RangeSelector(),
          ],
        ),
      ),
      const SizedBox(height: AppSizes.space5),
      Text(
        'BODY SUMMARY',
        style: AppTextStyles.label.copyWith(color: AppColors.textPrimary),
      ),
      const SizedBox(height: AppSizes.space2),
      const Row(
        children: [
          Expanded(
            child: _BodyCard(label: 'Weight', value: '75.6 kg'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _BodyCard(label: 'Body Fat', value: '18.2%'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _BodyCard(label: 'Muscle Mass', value: '56.1 kg'),
          ),
        ],
      ),
     
    ],
  );
}

LineChartData _weightChartData() {
  const historical = [
    FlSpot(0, 120),
    FlSpot(1, 122),
    FlSpot(2, 124),
    FlSpot(3, 123),
    FlSpot(4, 130),
    FlSpot(5, 127),
    FlSpot(6, 125),
    FlSpot(7, 128),
    FlSpot(8, 127),
    FlSpot(9, 131),
  ];
  const projected = [FlSpot(9, 131), FlSpot(9.5, 128), FlSpot(10, 136)];
  return LineChartData(
    minX: 0,
    maxX: 10,
    minY: 118,
    maxY: 140,
    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 5,
      getDrawingHorizontalLine: (_) => FlLine(
        color: AppColors.borderSubtle,
        strokeWidth: 1,
        dashArray: [4, 4],
      ),
    ),
    borderData: FlBorderData(show: false),
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          interval: 5,
          getTitlesWidget: (v, _) => Text(
            v.toInt().toString(),
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 2,
          getTitlesWidget: (v, _) {
            const months = ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov'];
            final i = (v / 2).round().clamp(0, 5);
            return Text(
              months[i],
              style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
            );
          },
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: historical,
        isCurved: true,
        color: AppColors.fitnessPositive,
        barWidth: 3,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: true, color: Color(0x183EBB78)),
      ),
      LineChartBarData(
        spots: projected,
        isCurved: true,
        color: AppColors.textPrimary,
        barWidth: 3,
        dotData: const FlDotData(show: false),
      ),
    ],
    extraLinesData: ExtraLinesData(
      verticalLines: [
        VerticalLine(x: 9, color: AppColors.fitnessPositive, strokeWidth: 1),
      ],
    ),
  );
}

class _RangeSelector extends StatelessWidget {
  const _RangeSelector();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface3,
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['90D', '6M', '1Y', 'ALL']
            .map(
              (x) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: x == '6M' ? AppColors.surface1 : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                ),
                child: Text(
                  x,
                  style: AppTextStyles.caption.copyWith(
                    color: x == '6M'
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  final String label, value;
  const _BodyCard({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => AppCard(
    padding:  EdgeInsets.symmetric(vertical: 12, horizontal: 15.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: 
          
AppTextStyles.caption.copyWith(
  color: AppColors.textPrimary,
  fontSize: 10.sp,
)        ),
         SizedBox(height: 5.h),
        Text(value, style: AppTextStyles.title),
      ],
    ),
  );
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Badge({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      children: [
        Icon(icon, color: AppColors.activityOrange, size: 28),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center, style: AppTextStyles.caption),
      ],
    ),
  );
}

class _WorkoutProgressContent extends StatelessWidget {
  final ProgressViewModel vm;
  const _WorkoutProgressContent({required this.vm});
  @override
  Widget build(BuildContext context) {
    final groups = vm.workoutData
        .asMap()
        .entries
        .map(
          (e) => BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: (e.value['minutes'] as int).toDouble(),
                color: AppColors.brandPrimary,
                width: 18,
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
        )
        .toList();
    return AppCard(
      child: SizedBox(
        height: 250,
        child: BarChart(
          BarChartData(
            maxY: 70,
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            barGroups: groups,
          ),
        ),
      ),
    );
  }
}

class _BodySummaryContent extends StatelessWidget {
  const _BodySummaryContent();
  @override
  Widget build(BuildContext context) => const _WeightProgressContent();
}
