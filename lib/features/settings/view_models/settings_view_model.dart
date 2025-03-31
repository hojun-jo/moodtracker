import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsViewModel extends AutoDisposeNotifier {
  @override
  build() {}

  Future<void> signOut() async {}
}

final settingsProvider = NotifierProvider.autoDispose(
  () => SettingsViewModel(),
);
