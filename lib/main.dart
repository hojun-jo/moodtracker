import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moodtracker/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Isar.initializeIsarCore();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const ProviderScope(
        child: MoodTrackerApp(),
      ),
    ),
  );
}
