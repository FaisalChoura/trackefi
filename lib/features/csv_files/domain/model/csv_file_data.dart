import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:file_picker/file_picker.dart';

class CsvFileData {
  PlatformFile? file;
  CsvImportSettings importSettings;
  CsvFileData(this.file, this.importSettings);
}
