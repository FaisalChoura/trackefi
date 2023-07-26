import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';

import '../repository/csv_files_repository.dart';

class ImportFilesUseCase {
  final CsvFilesRepository _csvFilesRepository;

  ImportFilesUseCase(this._csvFilesRepository);

  void execute(List<CsvFileData> filesData) {
    _csvFilesRepository.addFiles(filesData);
  }
}
