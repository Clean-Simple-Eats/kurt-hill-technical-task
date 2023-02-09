import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileProvider {
  Future<String> getFileContents(String filePath) async {
    final appDirectory = await getApplicationDocumentsDirectory();

    final file = File('${appDirectory.path}/$filePath');

    return file.readAsString();
  }
}
