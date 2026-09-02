import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProtectApp());
}

class ProtectApp extends StatelessWidget {
  const ProtectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROTECT Pest Control & AI HACCP Platform',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
