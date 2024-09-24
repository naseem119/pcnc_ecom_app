import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_widgets/auth_button.dart';
import '../widgets/auth_widgets/input_field.dart';
import '../widgets/auth_widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>(); // Get the existing instance
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // validate the entire form and attempt login if valid
  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      authController.loginUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isAuthenticated.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome\nBack!',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Username or email input field
                  InputField(
                    controller: authController.emailOrUsernameController,
                    labelText: 'Username or Email',
                    icon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 30),

                  // Password input field
                  PasswordField(
                    controller: authController.passwordController,
                    labelText: 'Password',
                  ),

                  Obx(() {
                    if (authController.errorMessage.value.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              authController.errorMessage.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Implement Forgot Password functionality
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFFCD3534),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Use the reusable AuthButton for login
                  AuthButton(
                    buttonText: 'Login',
                    onPressed: _validateAndLogin,
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Create An Account ',
                          style: TextStyle(fontSize: 14, color: Color(0xFF575757)),
                        ),
                        GestureDetector(
                          onTap: () {
                            authController.clearAuthControllers(); // Clear fields when switching to Sign Up
                            Get.offNamed('/signup');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFFCD3534),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
