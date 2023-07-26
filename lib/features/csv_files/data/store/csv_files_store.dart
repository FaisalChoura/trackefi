import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CsvFilesStore extends StateNotifier<List<CsvFileData>> {
  CsvFilesStore() : super([]);

  void addFiles(List<CsvFileData> filesData) {
    state = [...state, ...filesData];
  }

  void removeFile(CsvFileData fileData) {
    state = state.where((f) => f.file.path != fileData.file.path).toList();
  }
}
