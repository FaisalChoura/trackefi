import 'package:file_picker/file_picker.dart';

import '../../domain/repository/csv_files_repository.dart';
import '../store/csv_files_store.dart';

class CsvFilesRepositoryImpl implements CsvFilesRepository {
  final CsvFilesStore _store;
  CsvFilesRepositoryImpl(this._store);

  @override
  void addFiles(List<PlatformFile> files) {
    _store.addFiles(files);
  }

  @override
  void removeFile(PlatformFile file) {
    _store.removeFile(file);
  }
}
