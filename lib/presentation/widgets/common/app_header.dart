import 'package:flutter/material.dart';

import '../../../core/exports.dart';
import '../../theme/app_text_styles.dart';
import 'icon_action_button.dart';

enum AppHeaderType { primary, secondary }

class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final AppHeaderType type;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final Widget? leading;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.type = AppHeaderType.primary,
    this.onBack,
    this.actions = const [],
    this.leading,
  }) : assert(
         actions.length <= 2,
         'AppHeader supports a maximum of two actions.',
       );

  @override
  Widget build(BuildContext context) {
    final showBack = type == AppHeaderType.secondary;
    final resolvedLeading =
        leading ??
        (showBack
            ? IconActionButton(
                icon: Icons.arrow_back_rounded,
                tooltip: 'Back',
                semanticLabel: 'Go back',
                onPressed: onBack ?? () => Navigator.maybePop(context),
              )
            : null);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: AppSizes.appHeaderHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
        child: Row(
          children: [
            if (resolvedLeading != null) ...[
              resolvedLeading,
              const SizedBox(width: AppSizes.space3),
            ],
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.headingMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSizes.space1),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (actions.isNotEmpty) const SizedBox(width: AppSizes.space2),
            ...actions.map(
              (action) => ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: AppSizes.minTouchTarget,
                  minHeight: AppSizes.minTouchTarget,
                ),
                child: Center(child: action),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
