import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:isar/isar.dart';

class ImportSettingsDatabase {
  ImportSettingsDatabase(this._isar);
  final Isar _isar;

  Future<CsvImportSettings?> get(int id) async {
    return await _isar.csvImportSettings.get(id);
  }

  Future<List<CsvImportSettings>> getAll() async {
    return await _isar.csvImportSettings.where().findAll();
  }

  Future<CsvImportSettings?> putCategory(
      CsvImportSettings importSettings) async {
    return await _isar.writeTxn(() async {
      await _isar.csvImportSettings.put(importSettings);
      return importSettings;
    });
  }

  Future<bool> delete(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.csvImportSettings.delete(id);
    });
  }
}
