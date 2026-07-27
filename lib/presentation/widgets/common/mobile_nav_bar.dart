import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({super.key});

  static const _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home', route: AppRoutes.home),
    _NavItem(icon: Icons.fitness_center_rounded, label: 'Workouts', route: AppRoutes.workouts),
    _NavItem(icon: Icons.chat_bubble_rounded, label: 'AI Coach', route: AppRoutes.aiCoach),
    _NavItem(icon: Icons.trending_up_rounded, label: 'Progress', route: AppRoutes.progress),
    _NavItem(icon: Icons.person_rounded, label: 'Profile', route: AppRoutes.profile),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final location = GoRouterState.of(context).uri.path;

    return Container(
      height: AppSizes.navHeight,
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _items.map((item) {
          final isActive = location == item.route;
          return _NavButton(item: item, isActive: isActive, isDark: isDark);
        }).toList(),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final bool isDark;

  const _NavButton({
    required this.item,
    required this.isActive,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(item.route),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isActive
                  ? (isDark ? AppColors.white : AppColors.primary)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Icon(
              item.icon,
              size: AppSizes.iconLg,
              color: isActive
                  ? (isDark ? AppColors.primary : AppColors.white)
                  : (isDark ? Colors.grey[500] : Colors.grey[400]),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive
                  ? (isDark ? AppColors.white : AppColors.primary)
                  : (isDark ? Colors.grey[500] : Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;
  const _NavItem({required this.icon, required this.label, required this.route});
}
