import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

class CsvReaderService {
  Future<List<List<dynamic>>> readCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      final input = File(file.path!).openRead();
      return await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter(eol: "\n", fieldDelimiter: ","))
          .toList();
    }
    return [];
  }

  Future<List<PlatformFile>> importFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files;
    }
    return [];
  }

  Future<Map<int, List<List<dynamic>>>> convertFilesToCsv(
      List<PlatformFile> files) async {
    final Map<int, List<List<dynamic>>> convertedFilesMap = {};
    for (var i = 0; i < files.length; i++) {
      final file = files[i];
      final input = File(file.path!).openRead();
      final convertedFile = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter(eol: "\n", fieldDelimiter: ","))
          .toList();
      convertedFilesMap[i] = convertedFile;
    }
    return convertedFilesMap;
  }
}
