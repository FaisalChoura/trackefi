import 'package:file_picker/file_picker.dart';

import '../repository/csv_files_repository.dart';

class ImportFilesUseCase {
  final CsvFilesRepository _csvFilesRepository;

  ImportFilesUseCase(this._csvFilesRepository);

  void execute() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _csvFilesRepository.addFiles(result.files);
    }
    return;
  }
}
