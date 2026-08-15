import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';
import 'package:fitness_app/presentation/screens/viewmodels/exports.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ChallengeViewModel>();

    return Scaffold(
      body: Column(
        children: [
          DarkHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const DarkBackButton(),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.challengesTitle,
                              style: AppTextStyles.h3.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${vm.active.length} active · Push your limits',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(AppSizes.cardPadMd),
                  decoration: BoxDecoration(
                    color: AppColors.overlay10,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                    border: Border.all(color: AppColors.border20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.totalPoints,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '1,250',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '250 ${AppStrings.ptsToNextLevel}',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: AppColors.overlay10,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusXl,
                          ),
                          border: Border.all(color: AppColors.border20),
                        ),
                        child: Icon(
                          Icons.emoji_events_rounded,
                          color: Colors.white,
                          size: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(
              () => ListView(
                padding: EdgeInsets.fromLTRB(
                  AppSizes.screenPad,
                  AppSizes.lg,
                  AppSizes.screenPad,
                  100.h,
                ),
                children: [
                  Text(AppStrings.activeChallenges, style: AppTextStyles.h4),
                  SizedBox(height: 12.h),
                  ...vm.active.map((c) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: c.gradientColors,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMd,
                                    ),
                                  ),
                                  child: Icon(
                                    c.icon,
                                    color: Colors.white,
                                    size: AppSizes.iconLg,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        c.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.people_rounded,
                                            size: 12.sp,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            c.participants.toString(),
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF4F4F5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    AppSizes.radiusFull,
                                                  ),
                                            ),
                                            child: Text(
                                              '${c.daysLeft} days left',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xFF3F3F46),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  '${c.daysCompleted}/${c.totalDays} days',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: c.progressPercent,
                                minHeight: 8,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation(
                                  c.gradientColors.first,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${(c.progressPercent * 100).round()}% complete',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 10.sp,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: c.isComplete
                                      ? null
                                      : () {
                                          final prev = c.daysCompleted;
                                          vm.logDay(c.id);
                                          final next = (prev + 1).clamp(
                                            0,
                                            c.totalDays,
                                          );
                                          final isDone = next == c.totalDays;
                                          ToastHelper.show(
                                            context,
                                            isDone
                                                ? '🏆 Challenge complete!'
                                                : 'Day $next logged!',
                                            description: isDone
                                                ? 'You finished "${c.name}" — reward unlocked!'
                                                : '${c.totalDays - next} days remaining · Keep it up!',
                                            onUndo: () =>
                                                vm.undoLogDay(c.id, prev),
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(0, 34.h),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.logToday,
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 8),
                  Text(AppStrings.availableChallenges, style: AppTextStyles.h4),
                  const SizedBox(height: 12),

                  ...vm.available.map((c) {
                    final joined = vm.isJoined(c.id);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: c.gradientColors,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppSizes.radiusXl),
                                  topRight: Radius.circular(AppSizes.radiusXl),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(AppSizes.cardPadXl),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10.w),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: c.gradientColors,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.radiusMd,
                                          ),
                                        ),
                                        child: Icon(
                                          c.icon,
                                          color: Colors.white,
                                          size: AppSizes.iconLg,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              c.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                            if (c.description != null)
                                              Text(
                                                c.description!,
                                                style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 12,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.emoji_events_rounded,
                                        size: 14,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          c.reward,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: joined
                                            ? null
                                            : () {
                                                vm.joinChallenge(c.id);
                                                ToastHelper.show(
                                                  context,
                                                  '✅ Joined "${c.name}"!',
                                                  description:
                                                      'Your challenge starts today.',
                                                  onUndo: () {
                                                    vm.unjoinChallenge(c.id);
                                                    ToastHelper.show(
                                                      context,
                                                      'Left "${c.name}"',
                                                    );
                                                  },
                                                );
                                              },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: joined
                                                ? const Color(0xFFF4F4F5)
                                                : AppColors.primary,
                                            borderRadius: BorderRadius.circular(
                                              AppSizes.radiusLg,
                                            ),
                                          ),
                                          child: Text(
                                            joined
                                                ? AppStrings.joined
                                                : AppStrings.joinChallenge,
                                            style: TextStyle(
                                              color: joined
                                                  ? Colors.grey
                                                  : Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 8),
                  Text(AppStrings.yourAchievements, style: AppTextStyles.h4),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: vm.achievements.map((a) {
                      return AppCard(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(a.emoji, style: const TextStyle(fontSize: 32)),
                            const SizedBox(height: 6),
                            Text(
                              a.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              a.date,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const MobileNavBar(),
        ],
      ),
    );
  }
}
