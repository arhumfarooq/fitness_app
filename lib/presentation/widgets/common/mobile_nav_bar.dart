import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../theme/app_text_styles.dart';

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({super.key});

  static const _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home', route: AppRoutes.home),
    _NavItem(
      icon: Icons.fitness_center_rounded,
      label: 'Workouts',
      route: AppRoutes.workouts,
    ),
    _NavItem(
      icon: Icons.trending_up_rounded,
      label: 'Progress',
      route: AppRoutes.progress,
    ),
    _NavItem(
      icon: Icons.person_rounded,
      label: 'Profile',
      route: AppRoutes.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final location = GoRouterState.of(context).uri.path;

    return Container(
      height: AppSizes.bottomNavHeight,
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: _items.map((item) {
          final isActive = location == item.route;
          return Expanded(
            child: _NavButton(item: item, isActive: isActive),
          );
        }).toList(),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;

  const _NavButton({required this.item, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: item.label,
      child: GestureDetector(
        onTap: () => context.go(item.route),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(AppSizes.space1),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.activityContainer
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              child: Icon(
                item.icon,
                size: AppSizes.iconMd,
                color: isActive ? AppColors.brandPrimary : AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: isActive ? AppColors.textPrimary : AppColors.textMuted,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
