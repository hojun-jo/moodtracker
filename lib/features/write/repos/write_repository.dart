import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> post(String uid, Map<String, dynamic> mood) async {
    await _db.collection("users").doc(uid).collection("moods").add(mood);
  }
}

final writeRepo = Provider(
  (ref) => WriteRepository(),
);
