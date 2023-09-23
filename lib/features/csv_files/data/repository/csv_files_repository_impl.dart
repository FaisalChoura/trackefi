import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';

import '../../domain/repository/csv_files_repository.dart';
import '../store/csv_files_store.dart';

class CsvFilesRepositoryImpl implements CsvFilesRepository {
  final CsvFilesStore _store;
  CsvFilesRepositoryImpl(this._store);

  @override
  void addFiles(List<CsvFileData> filesData) {
    _store.addFiles(filesData);
  }

  @override
  void removeFile(CsvFileData fileData) {
    _store.removeFile(fileData);
  }

  @override
  void updateFile(CsvFileData fileData) {
    _store.updateFile(fileData);
  }
}
