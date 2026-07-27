import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class WorkoutLibraryScreen extends StatelessWidget {
  const WorkoutLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<WorkoutLibraryViewModel>();

    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Column(
              children: [
                Row(
                  children: [
                    const DarkBackButton(),
                    SizedBox(width: 14.w),
                    Text(AppStrings.workoutLibrary,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(height: 16.h),
                TextField(
                  onChanged: vm.search,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: AppStrings.searchWorkouts,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon:
                        Icon(Icons.search_rounded, color: Colors.grey[400]),
                    filled: true,
                    fillColor: AppColors.overlay10,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusLg),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                      AppSizes.screenPad, AppSizes.lg, AppSizes.screenPad, 100.h),
                  itemCount: vm.filtered.length,
                  itemBuilder: (ctx, i) {
                    final cat = vm.filtered[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () =>
                            context.push('${AppRoutes.exercise}/${cat.id}'),
                        child: AppCard(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSizes.radiusXl),
                                  topRight: Radius.circular(AppSizes.radiusXl),
                                ),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: cat.imageUrl,
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
                                      top: 14,
                                      left: 14,
                                      child: Container(
                                        padding: EdgeInsets.all(10.w),
                                        decoration: BoxDecoration(
                                          color: cat.color,
                                          borderRadius: BorderRadius.circular(
                                              AppSizes.radiusMd),
                                        ),
                                        child: Icon(cat.icon,
                                            color: Colors.white,
                                            size: AppSizes.iconLg),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 14,
                                      left: 14,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(cat.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.w700)),
                                          Text('${cat.exercises} exercises',
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 12.sp)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(AppSizes.cardPadMd),
                                child: Row(
                                  children: [
                                    _InfoChip('Difficulty', cat.difficulty),
                                    SizedBox(width: 16.w),
                                    _InfoChip('Duration',
                                        '${cat.durationMinutes} min'),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () => context.push(
                                          '${AppRoutes.exercise}/${cat.id}'),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(0, 38.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w)),
                                      child: Text(AppStrings.startBtn),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          const MobileNavBar(),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip(this.label, this.value);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 10.sp)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 13.sp)),
        ],
      );
}
