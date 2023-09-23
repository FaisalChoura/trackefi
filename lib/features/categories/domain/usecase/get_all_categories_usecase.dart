import 'package:Trackefi/features/categories/domain/model/category.dart';
import 'package:Trackefi/features/categories/domain/repository/categories_repository.dart';

class GetAllCategoriesUseCase {
  final CategoriesRepository _categoriesRepository;

  const GetAllCategoriesUseCase(this._categoriesRepository);

  Future<List<Category>> execute() async {
    return await _categoriesRepository.getAllCategories();
  }
}
