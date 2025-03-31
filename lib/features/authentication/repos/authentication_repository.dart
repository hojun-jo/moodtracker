import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  Future<UserCredential> signUp(
    String email,
    String password,
  ) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider.autoDispose(
  (ref) => AuthenticationRepository(),
);
