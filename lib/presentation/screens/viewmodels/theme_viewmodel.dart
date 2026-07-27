import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeViewModel extends GetxController {
  final _isDark = false.obs;
  bool get isDark => _isDark.value;

  void toggleTheme() {
    _isDark.value = !_isDark.value;
    Get.changeThemeMode(_isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
