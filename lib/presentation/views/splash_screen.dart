// lib/presentation/views/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        Get.offAllNamed('/dashboard');
      } else {
        Get.offAllNamed('/login');
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 274.0,
          height: 251.0,
        ),
      ),
    );
  }
}
