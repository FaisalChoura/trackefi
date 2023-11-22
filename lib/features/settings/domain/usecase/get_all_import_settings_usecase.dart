import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllImportSettingsUseCase {
  GetAllImportSettingsUseCase(this._importSettingsRepository);

  final ImportSettingsRepository _importSettingsRepository;

  Future<List<CsvImportSettings>?> execute() async {
    final allImportSettings =
        await _importSettingsRepository.getAllImportSettings();
    return allImportSettings;
  }
}

final getAllImportSettingsUseCase = Provider((ref) =>
    GetAllImportSettingsUseCase(ref.watch(importSettingsRepositoryProivder)));
