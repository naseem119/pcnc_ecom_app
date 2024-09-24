// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecom_app/presentation/controllers/auth_controller.dart';
import 'routes.dart';

void main() {
  final AuthController authController = Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Montserrat'),
      initialRoute: '/',
      getPages: appRoutes,
    );
  }
}
