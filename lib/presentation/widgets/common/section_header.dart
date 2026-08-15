import 'package:flutter/material.dart';

import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/presentation/theme/exports.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: AppSizes.minTouchTarget),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.title.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSizes.space3),
            trailing!,
          ],
        ],
      ),
    );
  }
}
