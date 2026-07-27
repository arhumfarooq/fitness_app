import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVm = Get.find<ThemeViewModel>();
    final profileVm = Get.find<ProfileViewModel>();
    final user = profileVm.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          DarkHeaderRounded(
            child: Column(
              children: [
                Container(
                  width: 88.w,
                  height: 88.w,
                  decoration: BoxDecoration(
                    color: AppColors.overlay10,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border20, width: 3),
                  ),
                  child: Icon(Icons.person_rounded,
                      color: Colors.white, size: 44.sp),
                ),
                SizedBox(height: 12.h),
                Text(user.name,
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 22.sp,
                       fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(user.email,
                   style: TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
                SizedBox(height: 12.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.overlay10,
                    borderRadius:
                        BorderRadius.circular(AppSizes.radiusFull),
                    border: Border.all(color: AppColors.border20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.workspace_premium_rounded,
                          color: Colors.amber, size: 16.sp),
                      SizedBox(width: 6.w),
                      Text(AppStrings.premiumMember,
                          style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  AppSizes.screenPad, AppSizes.lg, AppSizes.screenPad, 100.h),
              children: [
                AppCard(
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2,
                    children: [
                      _ProfileStat('Height', user.height),
                      _ProfileStat('Weight', user.weight),
                      _ProfileStat('Goal', user.goal),
                      _ProfileStat('Level', user.fitnessLevel),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                AppCard(
                  child: Obx(() => Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.borderDark
                                  : const Color(0xFFF4F4F5),
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusMd),
                            ),
                            child: Icon(
                              themeVm.isDark
                                  ? Icons.dark_mode_rounded
                                  : Icons.light_mode_rounded,
                              size: AppSizes.iconLg,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.darkMode,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp)),
                                Text(themeVm.isDark ? 'Enabled' : 'Disabled',
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12.sp)),
                              ],
                            ),
                          ),
                          Switch(
                            value: themeVm.isDark,
                            onChanged: (_) => themeVm.toggleTheme(),
                            activeColor: AppColors.primary,
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 16.h),

                AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _MenuItem(
                          icon: Icons.settings_rounded,
                          label: AppStrings.accountSettings,
                          onTap: () {}),
                      _MenuItem(
                          icon: Icons.notifications_rounded,
                          label: AppStrings.notifications,
                          onTap: () =>
                              context.push(AppRoutes.notifications)),
                      _MenuItem(
                          icon: Icons.workspace_premium_rounded,
                          label: AppStrings.subscription,
                          badge: AppStrings.premium,
                          iconColor: Colors.amber,
                          onTap: () {}),
                      _MenuItem(
                          icon: Icons.shield_rounded,
                          label: AppStrings.privacySecurity,
                          onTap: () {}),
                      _MenuItem(
                          icon: Icons.help_rounded,
                          label: AppStrings.helpSupport,
                          onTap: () {},
                          showDivider: false),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                Text(
                 'Member since ${user.joinDate}',
                 textAlign: TextAlign.center,
                 style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
                ),
                SizedBox(height: 16.h),

                GestureDetector(
                  onTap: () => context.go(AppRoutes.login),
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.cardPadLg),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_rounded, color: AppColors.error, size: 20.sp),
                        SizedBox(width: 10.w),
                        Text(AppStrings.logOut,
                            style: TextStyle(
                                color: AppColors.error,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp)),
                      ],
                    ),
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

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color:
            isDark ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: TextStyle(color: Colors.grey[500], fontSize: 11.sp)),
          SizedBox(height: 4.h),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 15.sp)),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? badge;
  final Color? iconColor;
  final bool showDivider;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
    this.iconColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.cardPadXl,
                vertical: AppSizes.cardPadMd),
            child: Row(
              children: [
                Icon(icon,
                    size: AppSizes.iconMd,
                    color: iconColor ?? Colors.grey),
                SizedBox(width: 14.w),
                Expanded(
                   child: Text(label,
                       style: TextStyle(
                           fontWeight: FontWeight.w500, fontSize: 15.sp))),
                if (badge != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF9C3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(badge!,
                        style: TextStyle(
                            color: const Color(0xFFCA8A04), fontSize: 11.sp)),
                  ),
                SizedBox(width: 8.w),
                Icon(Icons.chevron_right_rounded,
                    color: Colors.grey[400], size: AppSizes.iconMd),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: Theme.of(context).dividerColor),
      ],
    );
  }
}
