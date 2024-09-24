// lib/routes.dart
import 'package:get/get.dart';
import 'presentation/views/sign_up_screen.dart';
import 'presentation/views/dashboard_screen.dart';
import 'presentation/views/login_screen.dart';
import 'presentation/views/splash_screen.dart';
import 'presentation/views/category_screen.dart';

final List<GetPage> appRoutes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/signup', page: () => SignUpScreen()),
  GetPage(name: '/dashboard', page: () => DashboardScreen()),
  GetPage(name: '/categories', page: () => CategoryScreen()),
];
