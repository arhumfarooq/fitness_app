import 'package:fitness_app/presentation/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<SignUpViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.screenPad),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 28),
              Text(AppStrings.createAccount, style: AppTextStyles.h2),
              const SizedBox(height: 6),
              Text(AppStrings.createAccountSub,
                  style: TextStyle(color: Colors.grey[500], fontSize: 14)),
              const SizedBox(height: 32),

              AppCard(
                child: Column(
                  children: [
                    Obx(() => AppTextField(
                          label: AppStrings.fullName,
                          hint: AppStrings.fullNameHint,
                          controller: vm.nameCtrl,
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          errorText: vm.nameError,
                          onChanged: (_) {},
                          onEditingComplete: vm.touchName,
                        )),
                    const SizedBox(height: 16),
                    Obx(() => AppTextField(
                          label: AppStrings.email,
                          hint: AppStrings.emailHint,
                          controller: vm.emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.mail_outline_rounded),
                          errorText: vm.emailError,
                          onChanged: (_) {},
                          onEditingComplete: vm.touchEmail,
                        )),
                    const SizedBox(height: 16),
                    Obx(() => AppTextField(
                          label: AppStrings.password,
                          hint: AppStrings.passwordCreateHint,
                          controller: vm.passwordCtrl,
                          obscureText: !vm.showPassword.value,
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(vm.showPassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: vm.togglePassword,
                          ),
                          errorText: vm.passwordError,
                          onChanged: (_) {},
                          onEditingComplete: vm.touchPassword,
                        )),
                    const SizedBox(height: 12),
                    Text(
                      '${AppStrings.termsText}${AppStrings.termsLink}${AppStrings.andText}${AppStrings.privacyLink}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Obx(() => AppButton(
                          label: AppStrings.createAccount,
                          isLoading: vm.isLoading.value,
                          onPressed: () async {
                            final ok = await vm.signUp();
                            if (ok && context.mounted) {
                              ToastHelper.success(context, 'Account created! 🎉');
                              context.go(AppRoutes.home);
                            }
                          },
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(AppStrings.haveAccount,
                    style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: Text(AppStrings.signInLink,
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700)),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
