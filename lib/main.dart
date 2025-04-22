import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtfridge/controllers/theme_controller.dart';
import 'package:wtfridge/firebase_options.dart';
import 'package:wtfridge/screens/image_classify_screen.dart';
import 'package:wtfridge/screens/login_screen.dart';
import 'package:wtfridge/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(ThemeController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: Get.find<ThemeController>().themeMode,
      home: LoginScreen(),
    );
  }
}
