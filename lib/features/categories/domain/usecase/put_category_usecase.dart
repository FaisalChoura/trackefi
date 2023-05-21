import 'package:expense_categoriser/features/categories/domain/model/category.dart';
import 'package:expense_categoriser/features/categories/domain/repository/categories_repository.dart';

class PutCategoryUseCase {
  final CategoriesRepository _categoriesRepository;

  const PutCategoryUseCase(this._categoriesRepository);

  Future<Category?> execute(Category category) async {
    return await _categoriesRepository.putCategory(category);
  }
}
