import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PutImportSettingsUseCase {
  PutImportSettingsUseCase(this._importSettingsRepository);

  final ImportSettingsRepository _importSettingsRepository;

  Future<CsvImportSettings?> execute(CsvImportSettings report) async {
    final savedImportSetting =
        await _importSettingsRepository.putImportSettings(report);
    return savedImportSetting;
  }
}

final putImportSettingsUseCase = Provider((ref) =>
    PutImportSettingsUseCase(ref.watch(importSettingsRepositoryProivder)));
