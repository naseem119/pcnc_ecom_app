import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Validators {
  static final RxString errorMessage = ''.obs;

  static bool isValidSignUpForm(String username, String email, String password, String confirmPassword) {
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      errorMessage.value = "Please fill in all the fields";
      return false;
    }

    if (!_isValidUsername(username)) {
      errorMessage.value = "Username must be 4-20 characters and no spaces or illegal characters";
      return false;
    }

    if (!_isValidEmail(email)) {
      errorMessage.value = "Please enter a valid email address";
      return false;
    }

    if (!_isValidPassword(password, username)) {
      return false;
    }

    if (password != confirmPassword) {
      errorMessage.value = "Passwords do not match";
      return false;
    }

    return true;
  }

  static bool _isValidUsername(String username) {
    RegExp usernameRegex = RegExp(r"^[a-zA-Z0-9_]{4,20}$");
    return usernameRegex.hasMatch(username);
  }

  static bool _isValidEmail(String email) {
    RegExp emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");

    if (email.length > 50) {
      errorMessage.value = "Email cannot be longer than 50 characters";
      return false;
    }

    if (!emailRegex.hasMatch(email)) {
      errorMessage.value = "Please enter a valid email address";
      return false;
    }

    return true;
  }

  static bool _isValidPassword(String password, String username) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    // this is not used because the API doesnt allow passwords with special characters
    bool hasSpecialChars = password.contains(RegExp(r'[!@#$&*~;:<>?=+\-_\[\]{}()|^%]'));
    bool isSimilarToUsername = password.contains(username);
    bool hasThreeConsecutiveChars = password.contains(RegExp(r'(.)\1\1')) || password.contains(RegExp(r'(\d)\1\1'));

    if (!hasUppercase || !hasLowercase || !hasDigits) {
      errorMessage.value = "Password must contain at least 1 uppercase, 1 lowercase, 1 number";
      return false;
    }

    if (isSimilarToUsername) {
      errorMessage.value = "Password cannot be similar to your username";
      return false;
    }

    if (hasThreeConsecutiveChars) {
      errorMessage.value = "Password cannot contain three consecutive identical characters or numbers";
      return false;
    }

    return true;
  }
}
