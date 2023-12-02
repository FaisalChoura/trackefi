import 'package:Trackefi/features/categories/data/data_module.dart';
import 'package:Trackefi/features/categories/domain/repository/categories_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateAllMetaDataReportUseCase {
  final CategoriesRepository _categoriesRepository;
  GenerateAllMetaDataReportUseCase(this._categoriesRepository);

  Future<Map<dynamic, dynamic>> execute() async {
    final json = {};
    final categories = await _categoriesRepository.getAllCategories();
    json['categories'] = categories.map((e) => e.toJson()).toList();
    return json;
  }
}

final generateAllMetaDataReportUseCaseProvider = Provider((ref) =>
    GenerateAllMetaDataReportUseCase(ref.watch(categoriesRepositoryProvider)));
