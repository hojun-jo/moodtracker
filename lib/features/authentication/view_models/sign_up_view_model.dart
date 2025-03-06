import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/providers/user_notifier.dart';
import 'package:moodtracker/core/utils/validator.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';

class SignUpViewModel extends AsyncNotifier {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUp(email, password);

      ref.read(userProvider.notifier).createUser(userCredential);
    });
  }

  String? validateEmail(String? email) {
    if (email == null || !Validator.validateEmail(email)) {
      return "Please type a valid email.";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || !Validator.validatePassword(password)) {
      return "8 Characters or longer.";
    }
    return null;
  }

  String? validateRepeatPassword(String? repeatPassword, String? password) {
    if (password == null ||
        repeatPassword == null ||
        password != repeatPassword) {
      return "Password is not match.";
    }
    return null;
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
