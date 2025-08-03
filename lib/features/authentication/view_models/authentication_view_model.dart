import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/providers/provider.dart';
import 'package:moodtracker/features/authentication/utils/authentication_error.dart';

class AuthenticationViewModel extends AutoDisposeNotifier<AsyncValue<bool>> {
  @override
  AsyncValue<bool> build() {
    return ref.watch(authenticationRepositoryProvider).when(
          data: (data) => AsyncValue.data(data),
          error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
          loading: () => const AsyncValue.loading(),
        );
  }

  Future<void> googleSignIn() async {
    try {
      await ref.read(authenticationRepositoryProvider.notifier).googleSignIn();
    } on AuthenticationError catch (e) {
      if (e == AuthenticationError.canceled) {
        return;
      }
    }
  }

  Future<void> signOut() async {
    await ref.read(authenticationRepositoryProvider.notifier).signOut();
  }

  Future<void> deleteAccount() async {
    await ref.read(authenticationRepositoryProvider.notifier).deleteAccount();
  }
}
