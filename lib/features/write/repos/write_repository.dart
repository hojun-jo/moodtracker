import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/core/models/mood/mood_model.dart';

class WriteRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> post(MoodModel mood) async {
    await _db.collection("mood").doc(mood.uid).set(mood.toJson());
  }
}

final writeRepo = Provider(
  (ref) => WriteRepository(),
);
