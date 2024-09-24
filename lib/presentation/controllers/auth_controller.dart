import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../../utils/validators.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final TextEditingController emailOrUsernameController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isAuthenticated = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoggedInStatus();
  }

  @override
  void onClose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      isAuthenticated.value = true;
      Get.offAllNamed('/dashboard');
    }
  }

  bool isEmail(String input) {
    return input.contains('@');
  }

  Future<void> loginUser() async {
    String emailOrUsername = emailOrUsernameController.text.trim();
    String password = passwordController.text.trim();
    String? email;

    if (emailOrUsername.isEmpty || password.isEmpty) {
      _setErrorMessage("Please enter your username or email and password");
      return;
    }

    if (isEmail(emailOrUsername)) {
      email = emailOrUsername;
    } else {
      email = await _authService.fetchUserEmail(emailOrUsername);
      if (email == null) {
        _setErrorMessage("Invalid Credentials");
        return;
      }
    }

    final response = await _authService.login(email, password);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await _saveToken(data['access_token']);
      isAuthenticated.value = true;
      clearAuthControllers();
      Get.offAllNamed('/dashboard');
    } else {
      _setErrorMessage("Invalid credentials. Please try again.");
    }
  }

  Future<void> loginUserAfterSignUp(String email, String password) async {
    // set the email and password to the login fields manually
    emailOrUsernameController.text = email;
    passwordController.text = password;

    await loginUser();
    // clear the fields after successful login
    clearAuthControllers();
  }

  Future<bool> isEmailAvailable(String email) async {
    try {
      final users = await _authService.fetchAllUsers();

      // loop through the users to see if the email already exists
      for (var user in users) {
        if (user['email'].toLowerCase() == email.toLowerCase()) {
          return false; // email is already in use
        }
      }

      return true; // email is available
    } catch (e) {
      print("Error fetching users: $e");
      return false; // in case of error, assume email is not available
    }
  }


  Future<bool> isUsernameAvailable(String username) async {
    final email = await _authService.fetchUserEmail(username);
    return email ==
        null; // if fetchUserEmail returns null, the username is available
  }

  Future<void> signUpUser() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // validate the sign-up form before proceeding
    if (!_validateSignUpForm(username, email, password, confirmPassword))
      return;
    // check if email or username is already taken
    bool isEmailFree = await isEmailAvailable(email);
    bool isUsernameFree = await isUsernameAvailable(username);

    if (!isEmailFree) {
      _setErrorMessage("Email is already in use");
      return;
    }

    if (!isUsernameFree) {
      _setErrorMessage("Username is already taken");
      return;
    }
    // attempt to sign up the user
    final response = await _authService.signUp({
      "name": username,
      "email": email,
      "password": password,
      "avatar": "https://picsum.photos/800"
    });

    if (response.statusCode == 201) {
      // if sign-up is successful, log the user in automatically using their email and password
      await loginUserAfterSignUp(email, password);
    } else {
      _setErrorMessage("Error signing up. Please try again.");
    }
  }

  bool _validateSignUpForm(
      String username, String email, String password, String confirmPassword) {
    if (!Validators.isValidSignUpForm(
        username, email, password, confirmPassword)) {
      _setErrorMessage(Validators.errorMessage.value);
      return false;
    }
    return true;
  }

  void _setErrorMessage(String message) {
    errorMessage.value = message;
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isAuthenticated.value = false;
    Get.offAllNamed('/login');
  }

  void clearAuthControllers() {
    emailOrUsernameController.clear();
    passwordController.clear();
    usernameController.clear();
    emailController.clear();
    confirmPasswordController.clear();
    errorMessage.value = '';
  }
}
