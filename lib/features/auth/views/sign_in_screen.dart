import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/auth/views/widgets/auth_app_bar.dart';
import 'package:moodtracker/features/auth/views/widgets/auth_text_field.dart';
import 'package:moodtracker/route/route_path.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(title: "Welcome!"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              AuthTextField(
                emailController: _emailController,
                hintText: "Email",
                errorText: "asdf",
              ),
              AuthTextField(
                emailController: _passwordController,
                hintText: "Password",
                errorText: "asdf",
              ),
              GestureDetector(
                onTap: _signIn,
                child: const Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign In"),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _goToSignUp,
                child: const Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create Account"),
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

  void _signIn() {}

  void _goToSignUp() {
    context.push(RoutePath.signUp);
  }
}
