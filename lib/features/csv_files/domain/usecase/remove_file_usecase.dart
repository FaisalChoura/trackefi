import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';
import 'package:Trackefi/features/csv_files/domain/repository/csv_files_repository.dart';

class RemoveFileUseCase {
  RemoveFileUseCase(this._csvFilesRepository);
  final CsvFilesRepository _csvFilesRepository;

  void execute(CsvFileData fileData) {
    _csvFilesRepository.removeFile(fileData);
  }
}
