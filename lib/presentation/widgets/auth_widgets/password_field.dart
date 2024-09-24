// lib/presentation/widgets/password_field.dart
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible, // control password visibility
      decoration: InputDecoration(
        labelText: widget.labelText, // use the labelText from the widget
        filled: true,
        fillColor: const Color(0xFFF3F3F3),
        prefixIcon: const Icon(Icons.lock), // icon on the left side
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        // Toggle the visibility icon
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password'; // error message for empty password
        }
        return null; // return null if validation is successful
      },
    );
  }
}
