import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/exports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageSize = constraints.maxWidth.clamp(260.0, 420.0);

            return Stack(
              children: [
                Center(
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    tween: Tween(begin: 0.92, end: 1),
                    builder: (context, scale, child) {
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: Image.asset(
                      'assets/images/splash.png',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                      semanticLabel: 'Gymora AI fitness logo',
                    ),
                  ),
                ),
                Positioned(
                  left: AppSizes.screenPadding,
                  right: AppSizes.screenPadding,
                  bottom: AppSizes.majorSectionSpacing,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Train smarter. Live stronger.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSizes.space4),
                      AppButton(
                        label: AppStrings.getStarted,
                        color: AppColors.brandPrimary,
                        textColor: AppColors.onBrand,
                        onPressed: () => context.go(AppRoutes.login),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
