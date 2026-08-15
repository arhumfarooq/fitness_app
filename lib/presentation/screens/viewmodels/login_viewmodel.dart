import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_app/core/exports.dart';

class LoginViewModel extends GetxController {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final showPassword = false.obs;
  final isLoading = false.obs;
  final emailTouched = false.obs;
  final passwordTouched = false.obs;

  String? get emailError =>
      Validators.emailError(emailCtrl.text, touched: emailTouched.value);
  String? get passwordError => Validators.passwordError(
    passwordCtrl.text,
    touched: passwordTouched.value,
  );
  bool get canSubmit =>
      Validators.canSubmitLogin(emailCtrl.text, passwordCtrl.text);

  void togglePassword() => showPassword.value = !showPassword.value;
  void touchEmail() => emailTouched.value = true;
  void touchPassword() => passwordTouched.value = true;

  Future<bool> login() async {
    emailTouched.value = true;
    passwordTouched.value = true;
    if (!canSubmit) return false;

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    return true;
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}
