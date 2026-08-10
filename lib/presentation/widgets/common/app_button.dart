import 'package:flutter/material.dart';

import '../../../core/exports.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final buttonHeight = height ?? AppSizes.buttonHeight;
    final effectiveOnPressed = isLoading ? null : onPressed;

    if (isOutlined) {
      final foreground = textColor ?? color ?? scheme.onSurface;
      final customStyle = color == null && textColor == null
          ? null
          : OutlinedButton.styleFrom(
              foregroundColor: foreground,
              side: BorderSide(color: color ?? scheme.outline),
            );

      return SizedBox(
        width: width ?? double.infinity,
        height: buttonHeight,
        child: OutlinedButton(
          onPressed: effectiveOnPressed,
          style: customStyle,
          child: _child(foreground),
        ),
      );
    }

    final background = color ?? scheme.primary;
    final foreground = textColor ?? scheme.onPrimary;
    final customStyle = color == null && textColor == null
        ? null
        : ElevatedButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreground,
            disabledBackgroundColor: background.withValues(alpha: 0.45),
            disabledForegroundColor: foreground.withValues(alpha: 0.65),
          );

    return SizedBox(
      width: width ?? double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        style: customStyle,
        child: _child(foreground),
      ),
    );
  }

  Widget _child(Color foreground) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(
              color: foreground,
              strokeWidth: 2.5,
            ),
          ),
          const SizedBox(width: AppSizes.space2),
          Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
        ],
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: AppSizes.space2),
          Text(label),
        ],
      );
    }

    return Text(label);
  }
}
