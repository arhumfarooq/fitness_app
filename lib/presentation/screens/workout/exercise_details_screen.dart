import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/exports.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';
import '../../../data/repositories/exports.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final int categoryId;
  const ExerciseDetailsScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ExerciseDetailsViewModel>();
    final exercises = vm.getExercises(categoryId);
    final categories = WorkoutRepository.getCategories();
    final cat = categories.firstWhere((c) => c.id == categoryId,
        orElse: () => categories.first);

    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Row(
              children: [
                const DarkBackButton(),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(cat.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  AppSizes.screenPad, AppSizes.lg, AppSizes.screenPad, 100.h),
              children: [
                Obx(() => Container(
                      padding: EdgeInsets.all(AppSizes.cardPadXl),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.headerStart, Color(0xFF3F3F46)],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusXl),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                              'Set', '${vm.currentSet.value}/3', Colors.white),
                          _StatItem(
                              'Rest Time', '60s', Colors.grey.shade300),
                          _StatItem('Next Rest', '45s', Colors.grey.shade300),
                        ],
                      ),
                    )),
                SizedBox(height: 20.h),

                Obx(() => Column(
                      children: exercises.asMap().entries.map((entry) {
                        final i = entry.key;
                        final ex = entry.value;
                        final isActive = i == vm.currentExercise.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AppCard(
                            child: Row(
                              children: [
                                Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? AppColors.primary
                                        : const Color(0xFFF4F4F5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text('${i + 1}',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: isActive
                                                ? Colors.white
                                                : Colors.grey)),
                                  ),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(ex.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.sp,
                                              color: isActive
                                                  ? AppColors.primary
                                                  : null)),
                                      SizedBox(height: 4.h),
                                      Row(children: [
                                        _Tag('${ex.sets} sets'),
                                        SizedBox(width: 6.w),
                                        _Tag('${ex.reps} reps'),
                                        SizedBox(width: 6.w),
                                        _Tag('Rest ${ex.rest}'),
                                      ]),
                                      if (isActive) ...[
                                        SizedBox(height: 6.h),
                                        Text(ex.instructions,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey[600],
                                                height: 1.4)),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )),

                SizedBox(height: 12.h),
                Obx(() => AppButton(
                      label: vm.currentExercise.value < exercises.length - 1
                          ? 'Next Exercise'
                          : 'Finish Workout',
                      onPressed: () {
                        if (vm.currentExercise.value < exercises.length - 1) {
                          vm.nextExercise();
                        } else {
                          ToastHelper.success(context, 'Workout Complete! 🏆',
                              description:
                                  'Great job finishing all exercises!');
                          Navigator.of(context).pop();
                        }
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatItem(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(label,
              style: TextStyle(color: Colors.grey[400], fontSize: 11.sp)),
          SizedBox(height: 4.h),
          Text(value,
              style: TextStyle(
                  color: color,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700)),
        ],
      );
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F5),
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 10.sp, color: const Color(0xFF3F3F46))),
      );
}
