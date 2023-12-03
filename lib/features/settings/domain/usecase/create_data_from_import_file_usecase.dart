import 'package:Trackefi/features/categories/data/data_module.dart';
import 'package:Trackefi/features/categories/domain/model/category.dart';
import 'package:Trackefi/features/categories/domain/repository/categories_repository.dart';
import 'package:Trackefi/features/settings/data/data_module.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/repository/import_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateDataFromImportFileUseCase {
  final CategoriesRepository _categoriesRepository;
  final ImportSettingsRepository _importSettingsRepository;
  CreateDataFromImportFileUseCase(
      this._categoriesRepository, this._importSettingsRepository);
  Future<bool> execute(Map json) async {
    if (!_checkJsonMapIsValid(json)) {
      throw 'Import file does not match template';
    }
    try {
      if (json['categories'].isNotEmpty) {
        final listOfCategoriesJson = (json['categories'] as List<dynamic>);
        for (var categoryJson in listOfCategoriesJson) {
          await _categoriesRepository
              .putCategory(Category.fromJson(categoryJson));
        }
      }

      if (json['import_settings'].isNotEmpty) {
        final listOfImportSettings = (json['import_settings'] as List<dynamic>);
        for (var importSettingsJson in listOfImportSettings) {
          await _importSettingsRepository.putImportSettings(
              CsvImportSettings.fromJson(importSettingsJson));
        }
      }
    } catch (e) {
      // TODO handle errors properly
      rethrow;
    }

    return true;
  }

  bool _checkJsonMapIsValid(Map json) {
    const propertiesToCheck = ['categories', 'import_settings'];

    if (json.keys.isEmpty) {
      return false;
    }

    for (var key in json.keys) {
      if (!propertiesToCheck.contains(key)) {
        return false;
      }
    }

    return true;
  }
}

final createDataFromImportFileUseCaseProvider =
    Provider((ref) => CreateDataFromImportFileUseCase(
          ref.watch(categoriesRepositoryProvider),
          ref.watch(importSettingsRepositoryProivder),
        ));
