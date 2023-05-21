import 'package:expense_categoriser/features/categories/domain/model/category.dart';
import 'package:expense_categoriser/features/categories/domain/repository/categories_repository.dart';

class GetAllCategoriesUseCase {
  final CategoriesRepository _categoriesRepository;

  const GetAllCategoriesUseCase(this._categoriesRepository);

  Future<List<Category>> execute() async {
    return await _categoriesRepository.getAllCategories();
  }
}
