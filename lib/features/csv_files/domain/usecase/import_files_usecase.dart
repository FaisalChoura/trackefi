import 'package:file_picker/file_picker.dart';

class ImportFilesUseCase {
  Future<List<PlatformFile>> execute() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files;
    }
    return [];
  }
}
