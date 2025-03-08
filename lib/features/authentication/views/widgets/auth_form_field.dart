import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final String? Function(String?) validator;
  final Function(String?) onChanged;

  const AuthFormField({
    super.key,
    this.obscureText = false,
    required this.hintText,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          validator: validator,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
