import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteImportSettingsUseCase {
  DeleteImportSettingsUseCase(this._importSettingsRepository);

  final ImportSettingsRepository _importSettingsRepository;

  Future<bool?> execute(id) async {
    return await _importSettingsRepository.deleteImportSettings(id);
  }
}

final deleteImportSettingsUseCaseProvider = Provider((ref) =>
    DeleteImportSettingsUseCase(ref.watch(importSettingsRepositoryProivder)));
