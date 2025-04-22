import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkTheme = false.obs;

  ThemeMode get themeMode => isDarkTheme.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeThemeMode(themeMode);
  }
}
