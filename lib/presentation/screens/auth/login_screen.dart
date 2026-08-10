import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/auth/auth_shell.dart';
import '../../widgets/auth/premium_brand_mark.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<LoginViewModel>();

    return AuthShell(
      brand: Column(
        children: [
          const PremiumBrandMark(),
          const SizedBox(height: AppSizes.space4),
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
                const SizedBox(height: AppSizes.space5),
                _divider(context),
                const SizedBox(height: AppSizes.space4),
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        label: 'Google',
                        icon: Icons.g_mobiledata_rounded,
                        onPressed: () => context.go(AppRoutes.home),
                      ),
                    ),
                    const SizedBox(width: AppSizes.space3),
                    Expanded(
                      child: _SocialButton(
                        label: 'Apple',
                        icon: Icons.apple_rounded,
                        onPressed: () => context.go(AppRoutes.home),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.space5),
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

  Widget _divider(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.space3),
          child: Text(
            AppStrings.orContinueWith,
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: AppSizes.iconMd),
      label: Text(label, style: AppTextStyles.label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, AppSizes.buttonHeight),
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.borderSubtle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
      ),
    );
  }
}
