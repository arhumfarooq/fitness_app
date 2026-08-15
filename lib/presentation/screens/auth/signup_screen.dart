import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_app/core/exports.dart';
import 'package:fitness_app/routes/app_router.dart';
import 'package:fitness_app/presentation/theme/exports.dart';
import 'package:fitness_app/presentation/widgets/exports.dart';
import 'package:fitness_app/presentation/screens/viewmodels/exports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<SignUpViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.screenPad),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const PremiumBrandMark(),
              const SizedBox(height: AppSizes.space5),
              Text(AppStrings.createAccount, style: AppTextStyles.headingLarge),
              const SizedBox(height: AppSizes.space2),
              Text(
                AppStrings.createAccountSub,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSizes.space6),

              AppCard(
                child: Column(
                  children: [
                    Obx(
                      () => AppTextField(
                        label: AppStrings.fullName,
                        hint: AppStrings.fullNameHint,
                        controller: vm.nameCtrl,
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        errorText: vm.nameError,
                        onChanged: (_) {},
                        onEditingComplete: vm.touchName,
                      ),
                    ),
                    const SizedBox(height: AppSizes.space4),
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
                        hint: AppStrings.passwordCreateHint,
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
                    Text(
                      '${AppStrings.termsText}${AppStrings.termsLink}${AppStrings.andText}${AppStrings.privacyLink}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => AppButton(
                        label: AppStrings.createAccount,
                        isLoading: vm.isLoading.value,
                        onPressed: () async {
                          final ok = await vm.signUp();
                          if (ok && context.mounted) {
                            ToastHelper.success(context, 'Account created! 🎉');
                            context.go(AppRoutes.personalInfo);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.space5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.haveAccount,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.login),
                    child: Text(
                      AppStrings.signInLink,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
