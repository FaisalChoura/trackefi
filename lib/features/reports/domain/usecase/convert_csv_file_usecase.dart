import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/domain/errors/exceptions.dart';

class ConvertCsvFileUseCase {
  // TODO Name this type
  Future<Map<int, List<List<dynamic>>>> execute(
      List<CsvFileData> filesData) async {
    if (filesData.isEmpty) throw NoCsvFileImportedException();

    final Map<int, List<List<dynamic>>> convertedFilesMap = {};
    for (var i = 0; i < filesData.length; i++) {
      final file = filesData[i].file;
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
