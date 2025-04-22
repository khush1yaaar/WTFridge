
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wtfridge/firebase_options.dart';
import 'package:wtfridge/screens/image_classify.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ImageClassify(),
    );
  }
}
