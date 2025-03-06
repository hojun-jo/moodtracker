import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/user/user_model.dart';
import 'package:moodtracker/core/repos/user_repository.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';

class UserNotifier extends AsyncNotifier<UserModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final user =
          await _userRepository.findUser(_authenticationRepository.user!.uid);
      if (user != null) {
        return UserModel.fromJson(user);
      }
    }

    return UserModel.empty();
  }

  Future<void> createUser(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = UserModel(
        uid: credential.user!.uid,
        name: credential.user!.displayName ?? "Anon",
        email: credential.user!.email ?? "abcd@abcd.com",
      );

      await _userRepository.createUser(user);

      return user;
    });
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, UserModel>(
  () => UserNotifier(),
);
