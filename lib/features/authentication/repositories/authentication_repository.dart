import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/user_model.dart';

abstract interface class AuthenticationRepository
    extends AutoDisposeStreamNotifier<bool> {
  Stream<bool> authState();
  Future<UserModel> googleSignIn();
  Future<UserModel> appleSignIn();
  Future<void> signOut();
  Future<void> deleteAccount();
}
