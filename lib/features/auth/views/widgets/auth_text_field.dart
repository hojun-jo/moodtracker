import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController emailController;
  final String hintText;
  final String? errorText;

  const AuthTextField({
    super.key,
    required this.emailController,
    required this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
          ),
        ),
      ),
    );
  }
}
