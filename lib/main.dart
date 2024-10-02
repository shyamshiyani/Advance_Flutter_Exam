import 'package:contact_dairy_app/views/screens/backUp_Screen.dart';
import 'package:contact_dairy_app/views/screens/home_Screen.dart';
import 'package:contact_dairy_app/views/screens/splash_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'Splash_Screen',
    routes: {
      "/": (context) => const HomeScreen(),
      "Backup_Screen": (context) => const BackupScreen(),
      "Splash_Screen": (context) => const SplashScreen(),
    },
  ));
}
