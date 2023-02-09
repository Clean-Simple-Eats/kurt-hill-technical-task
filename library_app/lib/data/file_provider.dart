import 'package:flutter/services.dart';

class FileProvider {
  Future<String> getFileContents(String fileName) async {
    return await rootBundle.loadString('assets/$fileName');
  }
}
