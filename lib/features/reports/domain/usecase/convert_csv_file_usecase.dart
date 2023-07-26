import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/reports/domain/enum/csv_file_chunk_size_enum.dart';

import '../../../../core/domain/errors/exceptions.dart';

typedef ConvertedCsvFile = Map<int, List<List<dynamic>>>;

class ConvertCsvFileUseCase {
  Future<ConvertedCsvFile> execute(List<CsvFileData> filesData,
      [CsvFileChunkSizeEnum chunkSize = CsvFileChunkSizeEnum.full]) async {
    if (filesData.isEmpty) throw NoCsvFileImportedException();
    // TODO use end of line from import settings
    final Map<int, List<List<dynamic>>> convertedFilesMap = {};
    for (var i = 0; i < filesData.length; i++) {
      final file = filesData[i].file;
      final input = File(file.path!).openRead();
      List<List<dynamic>> convertedFile = [];
      if (chunkSize == CsvFileChunkSizeEnum.full) {
        convertedFile = await input
            .transform(utf8.decoder)
            .transform(CsvToListConverter(
                eol: "\n",
                fieldDelimiter: filesData[i].importSettings.fieldDelimiter))
            .toList();
      } else {
        convertedFile = await input
            .take(1)
            .transform(utf8.decoder)
            .transform(CsvToListConverter(
                eol: "\n",
                fieldDelimiter: filesData[i].importSettings.fieldDelimiter))
            .toList();
      }
      convertedFilesMap[i] = convertedFile;
    }
    return convertedFilesMap;
  }
}
