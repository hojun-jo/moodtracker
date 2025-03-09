import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/widgets/error_dialog.dart';
import 'package:moodtracker/features/authentication/view_models/sign_in_view_model.dart';
import 'package:moodtracker/features/authentication/views/widgets/auth_app_bar.dart';
import 'package:moodtracker/features/authentication/views/widgets/auth_form_field.dart';
import 'package:moodtracker/route/route_path.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  late final SignInViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(signInProvider.notifier);
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
              Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    AuthFormField(
                      hintText: "Email",
                      validator: _validateEamil,
                      onChanged: _changeEmail,
                    ),
                    AuthFormField(
                      obscureText: true,
                      hintText: "Password",
                      validator: _validatePassword,
                      onChanged: _changePassword,
                    ),
                  ],
                ),
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
                onTap: _pushSignUpScreen,
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

  String? _validateEamil(String? value) {
    return _viewModel.validateEmail(value);
  }

  void _changeEmail(String? value) {
    if (value != null) {
      _formData["email"] = value;
    }
  }

  String? _validatePassword(String? value) {
    return _viewModel.validatePassword(value);
  }

  void _changePassword(String? value) {
    if (value != null) {
      _formData["password"] = value;
    }
  }

  void _signIn() {
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      try {
        _viewModel.signIn(
          _formData["email"]!,
          _formData["password"]!,
        );
        context.go(RoutePath.home);
      } catch (e) {
        showErrorDialog(
          context: context,
          text: e.toString(),
        );
      }
    }
  }

  void _pushSignUpScreen() {
    context.push(RoutePath.signUp);
  }
}
