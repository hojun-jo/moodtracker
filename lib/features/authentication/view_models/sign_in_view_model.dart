import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/utils/validator.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';

class SignInViewModel extends AutoDisposeAsyncNotifier {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepo.signIn(email, password);
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
}

final signInProvider = AsyncNotifierProvider.autoDispose<SignInViewModel, void>(
  () => SignInViewModel(),
);
