import 'package:Trackefi/features/csv_files/domain/model/import_settings.dart';
import 'package:file_picker/file_picker.dart';

class CsvFileData {
  PlatformFile file;
  CsvImportSettings importSettings;
  CsvFileData(this.file, this.importSettings);
}
