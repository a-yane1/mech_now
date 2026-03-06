import 'package:flutter/material.dart';
import 'Screens/onboarding/splash_screen.dart';
import 'app_theme.dart';

void main() {
  runApp(const MechNowApp());
}

class MechNowApp extends StatelessWidget {
  const MechNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MechNow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const SplashScreen(),
    );
  }
}
