import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';

import '../repository/csv_files_repository.dart';

class UpdateFileUseCase {
  final CsvFilesRepository _csvFilesRepository;

  UpdateFileUseCase(this._csvFilesRepository);

  void execute(CsvFileData fileData) {
    _csvFilesRepository.updateFile(fileData);
  }
}
