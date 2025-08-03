import 'package:moodtracker/core/models/user_model.dart';

abstract interface class AuthenticationDatasource {
  Stream<bool> authState();
  Future<UserModel> googleSignIn();
  Future<UserModel> appleSignIn();
  Future<void> signOut();
  Future<void> deleteAccount();
}
