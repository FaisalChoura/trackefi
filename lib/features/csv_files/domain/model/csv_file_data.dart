import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:file_selector/file_selector.dart';

class CsvFileData {
  XFile file;
  CsvImportSettings importSettings;
  CsvFileData(this.file, this.importSettings);
}
