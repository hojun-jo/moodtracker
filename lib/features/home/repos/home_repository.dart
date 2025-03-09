import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMoods(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("moods")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<void> deleteMood({
    required String uid,
    required String id,
  }) async {
    _db.collection("users").doc(uid).collection("moods").doc(id).delete();
  }
}

final homeRepo = Provider.autoDispose(
  (ref) => HomeRepository(),
);
