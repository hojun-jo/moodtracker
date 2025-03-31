import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';

class SettingsViewModel extends AutoDisposeNotifier {
  late final AuthenticationRepository _authRepository;

  @override
  build() {
    _authRepository = ref.read(authRepo);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}

final settingsProvider = NotifierProvider.autoDispose(
  () => SettingsViewModel(),
);
