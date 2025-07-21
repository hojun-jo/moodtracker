import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/widgets/dialog/error_dialog.dart';
import 'package:moodtracker/features/authentication/views/widgets/auth_button.dart';
import 'package:moodtracker/features/settings/providers/provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign in to sync your saved entries.".tr(),
            textAlign: TextAlign.center,
          ),
          AuthButton(
            icon: FontAwesomeIcons.google,
            text: "Sign in with Google",
            onTap: () => _googleSignIn(context, ref),
          ),
          AuthButton(
            icon: FontAwesomeIcons.apple,
            text: "Sign in with Apple",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _googleSignIn(
    BuildContext context,
    WidgetRef ref,
  ) {
    try {
      ref.read(authenticationProvider.notifier).googleSignIn();
    } catch (e) {
      showErrorDialog(context: context, text: e.toString());
    }
  }
}
