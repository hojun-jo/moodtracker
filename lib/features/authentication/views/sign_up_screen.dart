import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/widgets/error_dialog.dart';
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
  late final SignUpViewModel _viewModel;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(signUpProvider.notifier);
  }

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
                      validator: _validateEamil,
                      onChanged: _changeEmail,
                    ),
                    AuthFormField(
                      obscureText: true,
                      hintText: "Password",
                      validator: _validatePassword,
                      onChanged: _changePassword,
                    ),
                    AuthFormField(
                      obscureText: true,
                      hintText: "Repeat password",
                      validator: _validateRepeatPassword,
                      onChanged: _changeRepeatPassword,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _signUp,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Sign Up"),
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

  String? _validateRepeatPassword(String? value) {
    return _viewModel.validateRepeatPassword(
      value,
      _formData["password"],
    );
  }

  void _changeRepeatPassword(String? value) {
    if (value != null) {
      _formData["repeatPassword"] = value;
    }
  }

  void _signUp() async {
    if (_isLoading) return;
    if (_formKey.currentState == null) return;
    if (_formKey.currentState!.validate()) {
      try {
        _setIsLoading(true);
        await _viewModel.signUp(
          _formData["email"]!,
          _formData["password"]!,
        );
        _setIsLoading(false);

        if (mounted) {
          context.go(RoutePath.home);
        }
      } catch (e) {
        if (mounted) {
          showErrorDialog(
            context: context,
            text: e.toString(),
          );
        }
      }
    }
  }

  void _setIsLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }
}
