import 'package:flutter/material.dart';
import 'package:fitness_app/core/exports.dart';

class AuthShell extends StatelessWidget {
  final Widget child;
  final Widget? brand;

  const AuthShell({super.key, required this.child, this.brand});

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: keyboardVisible
                    ? const ClampingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.screenPadding,
                  AppSizes.space5,
                  AppSizes.screenPadding,
                  AppSizes.space7,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSizes.space2),
                        if (brand != null) brand! else const SizedBox.shrink(),
                        const SizedBox(height: AppSizes.space5),
                        Expanded(child: child),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
