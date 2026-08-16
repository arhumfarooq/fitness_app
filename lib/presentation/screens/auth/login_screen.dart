import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';
import 'package:fitness_app/presentation/screens/viewmodels/exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<LoginViewModel>();

    return AuthShell(
      brand: Column(
        children: [
          Image.asset(
            'assets/images/front_logo.png',
            width: 180.w,
            fit: BoxFit.contain,
            semanticLabel: 'GYMORA AI logo',
          ),
          const SizedBox(height: AppSizes.space4+13),
          Text(
            AppStrings.welcomeBack,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.space2),
          Text(
            AppStrings.signInSub,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.space5),
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(AppSizes.radiusExtraLarge),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Column(
              children: [
                Obx(
                  () => AppTextField(
                    label: AppStrings.email,
                    hint: AppStrings.emailHint,
                    controller: vm.emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail_outline_rounded),
                    errorText: vm.emailError,
                    onChanged: (_) {},
                    onEditingComplete: vm.touchEmail,
                  ),
                ),
                const SizedBox(height: AppSizes.space4),
                Obx(
                  () => AppTextField(
                    label: AppStrings.password,
                    hint: AppStrings.passwordHint,
                    controller: vm.passwordCtrl,
                    obscureText: !vm.showPassword.value,
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        vm.showPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: vm.togglePassword,
                    ),
                    errorText: vm.passwordError,
                    onChanged: (_) {},
                    onEditingComplete: vm.touchPassword,
                  ),
                ),
                const SizedBox(height: AppSizes.space3),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.space2,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, AppSizes.minTouchTarget),
                      ),
                      child: Text(
                        AppStrings.forgotPassword,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.space2),
                Obx(
                  () => AppButton(
                    label: vm.isLoading.value
                        ? AppStrings.signingIn
                        : AppStrings.signIn,
                    isLoading: vm.isLoading.value,
                    color: AppColors.brandPrimary,
                    textColor: AppColors.onBrand,
                    onPressed: () async {
                      final ok = await vm.login();
                      if (ok && context.mounted) {
                        ToastHelper.success(
                          context,
                          'Welcome back, Alex!',
                          description: 'Redirecting to your dashboard...',
                        );
                        context.go(AppRoutes.home);
                      }
                    },
                  ),
                ),
              
              ],
            ),
          ),
            const SizedBox(height: AppSizes.space5 - 9),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSizes.space1,
                  children: [
                    Text(
                      AppStrings.noAccount,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.signup),
                      child: Text(
                        AppStrings.signUpLink,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
