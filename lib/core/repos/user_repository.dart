import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/user/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }

  Future<Map<String, dynamic>?> findUser(String uid) async {
    final snapshot = await _db.collection("users").doc(uid).get();
    return snapshot.data();
  }
}

final userRepo = Provider.autoDispose(
  (ref) => UserRepository(),
);
