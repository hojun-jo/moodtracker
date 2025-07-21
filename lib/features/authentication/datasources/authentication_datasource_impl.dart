import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moodtracker/features/authentication/datasources/authentication_datasource.dart';
import 'package:moodtracker/core/models/user_model.dart';

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  @override
  Stream<bool> authState() async* {
    await for (final user in FirebaseAuth.instance.authStateChanges()) {
      yield user != null;
    }
  }

  @override
  Future<UserModel> appleSignIn() {
    // TODO: implement appleSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
    }
  }

  @override
  Future<UserModel> googleSignIn() async {
    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    final credential =
        GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return UserModel(uid: userCredential.user!.uid);
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
