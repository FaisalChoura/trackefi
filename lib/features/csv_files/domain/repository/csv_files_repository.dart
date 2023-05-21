import 'package:file_picker/file_picker.dart';

abstract class CsvFilesRepository {
  void addFiles(List<PlatformFile> files);
  void removeFile(PlatformFile file);
}
