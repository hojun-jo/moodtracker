import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/providers/provider.dart';

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
    await ref.read(authenticationRepositoryProvider.notifier).googleSignIn();
  }

  Future<void> signOut() async {
    await ref.read(authenticationRepositoryProvider.notifier).signOut();
  }

  Future<void> deleteAccount() async {
    await ref.read(authenticationRepositoryProvider.notifier).deleteAccount();
  }
}
