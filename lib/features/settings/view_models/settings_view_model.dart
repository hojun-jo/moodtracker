import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/repos/authentication_repository.dart';

class SettingsViewModel extends Notifier {
  late final AuthenticationRepository _repository;

  @override
  build() {
    _repository = ref.read(authRepo);
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }
}

final settingsProvider = NotifierProvider(
  () => SettingsViewModel(),
);
