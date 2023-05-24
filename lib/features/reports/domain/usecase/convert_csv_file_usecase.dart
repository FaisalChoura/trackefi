import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/domain/errors/exceptions.dart';

class ConvertCsvFileUseCase {
  Future<Map<int, List<List<dynamic>>>> execute(
      List<PlatformFile> files) async {
    if (files.isEmpty) throw NoCsvFileImportedException();

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
