import "dart:convert";
import "dart:io";
import 'package:file_picker/file_picker.dart';
import "package:csv/csv.dart";

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
}
