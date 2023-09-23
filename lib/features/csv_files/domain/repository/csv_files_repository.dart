import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';

abstract class CsvFilesRepository {
  void addFiles(List<CsvFileData> filesData);
  void removeFile(CsvFileData fileData);
  void updateFile(CsvFileData fileData);
}
