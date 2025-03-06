import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/view_models/sign_up_view_model.dart';
import 'package:moodtracker/features/authentication/views/widgets/auth_app_bar.dart';
import 'package:moodtracker/features/authentication/views/widgets/auth_form_field.dart';
import 'package:moodtracker/route/route_path.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(title: "Create Account"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    AuthFormField(
                      hintText: "Email",
                      validator: (value) => ref
                          .read(signUpProvider.notifier)
                          .validateEmail(value),
                      onChanged: (value) {
                        if (value != null) {
                          _formData["email"] = value;
                        }
                      },
                    ),
                    AuthFormField(
                      obscureText: true,
                      hintText: "Password",
                      validator: (value) => ref
                          .read(signUpProvider.notifier)
                          .validatePassword(value),
                      onChanged: (value) {
                        if (value != null) {
                          _formData["password"] = value;
                        }
                      },
                    ),
                    AuthFormField(
                      obscureText: true,
                      hintText: "Repeat password",
                      validator: (value) => ref
                          .read(signUpProvider.notifier)
                          .validateRepeatPassword(
                            value,
                            _formData["password"],
                          ),
                      onChanged: (value) {
                        if (value != null) {
                          _formData["repeatPassword"] = value;
                        }
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _signUp,
                child: const Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign Up"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      ref.read(signUpProvider.notifier).signUp(
            _formData["email"]!,
            _formData["password"]!,
          );
      context.go(RoutePath.home);
    }
  }
}
