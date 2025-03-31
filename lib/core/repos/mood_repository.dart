import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMoods(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("moods")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<void> postMood(Map<String, dynamic> mood) async {
    await _db
        .collection("users")
        .doc(mood["uid"])
        .collection("moods")
        .doc(mood["id"])
        .set(mood);
  }

  Future<void> deleteMood({
    required String uid,
    required String id,
  }) async {
    _db.collection("users").doc(uid).collection("moods").doc(id).delete();
  }
}

final moodRepo = Provider.autoDispose(
  (ref) => MoodRepository(),
);
