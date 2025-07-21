import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/user_model.dart';
import 'package:moodtracker/features/authentication/datasources/authentication_datasource.dart';
import 'package:moodtracker/features/authentication/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AutoDisposeStreamNotifier<bool>
    implements AuthenticationRepository {
  final AuthenticationDatasource _datasource;

  AuthenticationRepositoryImpl({required AuthenticationDatasource datasource})
      : _datasource = datasource;

  @override
  Stream<bool> build() async* {
    yield* authState();
  }

  @override
  Future<UserModel> appleSignIn() {
    // TODO: implement appleSignIn
    throw UnimplementedError();
  }

  @override
  Stream<bool> authState() async* {
    yield* _datasource.authState();
  }

  @override
  Future<void> deleteAccount() async {
    await _datasource.deleteAccount();
  }

  @override
  Future<UserModel> googleSignIn() async {
    return await _datasource.googleSignIn();
  }

  @override
  Future<void> signOut() async {
    await _datasource.signOut();
  }
}
