import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/exports.dart';
import '../../../routes/app_router.dart';
import '../../widgets/exports.dart';
import '../viewmodels/exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.screenPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.h),

              // Logo
              Container(
                width: 76.w,
                height: 76.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 40),
              ),
              SizedBox(height: 28.h),

              Text(AppStrings.welcomeBack,
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 6.h),
              Text(AppStrings.signInSub,
                  style: TextStyle(color: Colors.grey[500], fontSize: 14.sp)),
              SizedBox(height: 32.h),

              AppCard(
                child: Column(
                  children: [
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
                    SizedBox(height: 16.h),

                    Obx(() => AppTextField(
                          label: AppStrings.password,
                          hint: AppStrings.passwordHint,
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
                    SizedBox(height: 8.h),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(AppStrings.forgotPassword,
                            style: const TextStyle(
                                color: AppColors.primary, fontSize: 13)),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Obx(() => AppButton(
                          label: vm.isLoading.value
                              ? AppStrings.signingIn
                              : AppStrings.signIn,
                          isLoading: vm.isLoading.value,
                          onPressed: () async {
                            final ok = await vm.login();
                            if (ok && context.mounted) {
                              ToastHelper.success(context, 'Welcome back, Alex! 👋',
                                  description: 'Redirecting to your dashboard…');
                              context.go(AppRoutes.home);
                            }
                          },
                        )),
                    SizedBox(height: 20.h),
                    _divider(context),
                    SizedBox(height: 16.h),

                    Row(children: [
                      Expanded(
                        child: _SocialButton(
                          label: 'Google',
                          icon: Icons.g_mobiledata_rounded,
                          onPressed: () => context.go(AppRoutes.home),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _SocialButton(
                          label: 'Apple',
                          icon: Icons.apple_rounded,
                          onPressed: () => context.go(AppRoutes.home),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(AppStrings.noAccount,
                    style: TextStyle(color: Colors.grey[500], fontSize: 14.sp)),
                TextButton(
                  onPressed: () => context.go(AppRoutes.signup),
                  child: Text(AppStrings.signUpLink,
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

  Widget _divider(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider()),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Text(AppStrings.orContinueWith,
            style: TextStyle(color: Colors.grey[500], fontSize: 12.sp)),
      ),
      const Expanded(child: Divider()),
    ]);
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
      icon: Icon(icon, size: 20.sp),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(0, AppSizes.btnLg),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
    );
  }
}
