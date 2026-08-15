import 'package:flutter/material.dart';

import 'package:fitness_app/core/exports.dart';

/// Safe-area and keyboard-aware foundation for migrated screens.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? header;
  final Widget? bottomNavigation;
  final EdgeInsetsGeometry? padding;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final Color? backgroundColor;

  const AppScaffold({
    super.key,
    required this.body,
    this.header,
    this.bottomNavigation,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.screenPadding,
    ),
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final content = padding == null
        ? body
        : Padding(padding: padding!, child: body);

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      body: SafeArea(
        bottom: bottomNavigation == null,
        child: Column(
          children: [
            if (header != null) header!,
            Expanded(child: content),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigation == null
          ? null
          : SafeArea(top: false, child: bottomNavigation!),
    );
  }
}
