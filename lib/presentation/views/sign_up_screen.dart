import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_widgets/auth_button.dart';
import '../widgets/auth_widgets/input_field.dart';
import '../widgets/auth_widgets/password_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.find<AuthController>(); // Get the existing instance
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // validate the entire form and attempt sign-up if valid
  void _validateAndSignUp() {
    if (_formKey.currentState!.validate()) {
      authController.signUpUser();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              const Text(
                'Create an\naccount',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 35),

              // Username input field
              InputField(
                controller: authController.usernameController,
                labelText: 'Username',
                icon: const Icon(Icons.person),
              ),
              const SizedBox(height: 30),

              // Email input field
              InputField(
                controller: authController.emailController,
                labelText: 'Email',
                icon: const Icon(Icons.email),
              ),
              const SizedBox(height: 30),

              // Password input field
              PasswordField(
                controller: authController.passwordController,
                labelText: 'Password',
              ),
              const SizedBox(height: 30),

              // Confirm Password input field
              PasswordField(
                controller: authController.confirmPasswordController,
                labelText: 'Confirm Password',
              ),

              const SizedBox(height: 20),

              // Error message display
              Obx(() {
                if (authController.errorMessage.value.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            authController.errorMessage.value,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),

              const SizedBox(height: 20),

              // Use the reusable AuthButton for signing up
              AuthButton(
                buttonText: 'Create Account',
                onPressed: _validateAndSignUp,
              ),

              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF575757)),
                    ),
                    GestureDetector(
                      onTap: () {
                        authController.clearAuthControllers(); // Clear fields when switching to Login
                        Get.offNamed('/login');
                      },
                      child: const Text(
                        'Login',
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
}
