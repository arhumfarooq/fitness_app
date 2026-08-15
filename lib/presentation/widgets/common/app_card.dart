import 'package:flutter/material.dart';

import 'package:fitness_app/core/exports.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final double? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius == null
        ? null
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          );
    final content = Padding(
      padding: padding ?? const EdgeInsets.all(AppSizes.cardPadding),
      child: child,
    );

    return Card(
      shape: radius,
      clipBehavior: onTap == null ? Clip.none : Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}
