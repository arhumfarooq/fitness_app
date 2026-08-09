import 'package:flutter/material.dart';

import '../../../core/exports.dart';

class IconActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;

  const IconActionButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.semanticLabel,
    required this.onPressed,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final customStyle = color == null && backgroundColor == null
        ? null
        : IconButton.styleFrom(
            foregroundColor: color,
            backgroundColor: backgroundColor,
            disabledForegroundColor: AppColors.textDisabled,
            minimumSize: const Size.square(AppSizes.minTouchTarget),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
          );

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: semanticLabel,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        style: customStyle,
        constraints: const BoxConstraints.tightFor(
          width: AppSizes.minTouchTarget,
          height: AppSizes.minTouchTarget,
        ),
        icon: Icon(icon),
      ),
    );
  }
}
