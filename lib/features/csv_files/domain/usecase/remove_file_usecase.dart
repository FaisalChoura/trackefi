import 'package:expense_categoriser/features/csv_files/domain/repository/csv_files_repository.dart';
import 'package:file_picker/file_picker.dart';

class RemoveFileUseCase {
  RemoveFileUseCase(this._csvFilesRepository);
  final CsvFilesRepository _csvFilesRepository;

  void execute(PlatformFile file) {
    _csvFilesRepository.removeFile(file);
  }
}
