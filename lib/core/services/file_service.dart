import 'package:flutter/services.dart';

class FileService {
  Future<String> readJsonFromFile(String jsonFilePath) async =>
      await rootBundle.loadString(jsonFilePath);
}
