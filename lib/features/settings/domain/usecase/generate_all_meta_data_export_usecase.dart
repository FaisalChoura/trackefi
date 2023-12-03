import 'package:Trackefi/features/categories/data/data_module.dart';
import 'package:Trackefi/features/categories/domain/repository/categories_repository.dart';
import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateAllMetaDataReportUseCase {
  final CategoriesRepository _categoriesRepository;
  final ImportSettingsRepository _importSettingsRepository;
  GenerateAllMetaDataReportUseCase(
      this._categoriesRepository, this._importSettingsRepository);

  Future<Map<dynamic, dynamic>> execute() async {
    final json = {};
    final categories = await _categoriesRepository.getAllCategories();
    json['categories'] = categories.map((e) => e.toJson()).toList();

    final importSettings =
        await _importSettingsRepository.getAllImportSettings();
    json['import_settings'] = importSettings.map((e) => e.toJson()).toList();
    return json;
  }
}

final generateAllMetaDataReportUseCaseProvider = Provider(
  (ref) => GenerateAllMetaDataReportUseCase(
    ref.watch(categoriesRepositoryProvider),
    ref.watch(importSettingsRepositoryProivder),
  ),
);
