import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class GetFirstTwoLinesOfFileUseCase {
  Future<List<String>> execute(PlatformFile file) async {
    final input = File(file.path!).openRead();
    final data = await input.take(1).transform(utf8.decoder).toList();
    return data[0].split('\n').take(2).toList();
  }
}
