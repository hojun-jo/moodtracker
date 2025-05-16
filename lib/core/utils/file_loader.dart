import 'package:flutter/services.dart';

abstract class FileLoader {
  Future<String> loadString(String path);
}

class AssetFileLoader implements FileLoader {
  @override
  Future<String> loadString(String path) async {
    return await rootBundle.loadString(path);
  }
}
