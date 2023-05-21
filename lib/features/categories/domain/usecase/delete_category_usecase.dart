import 'package:expense_categoriser/features/categories/domain/repository/categories_repository.dart';

class DeleteCategoryUseCase {
  final CategoriesRepository _categoriesRepository;

  const DeleteCategoryUseCase(this._categoriesRepository);

  Future<bool> execute(int id) async {
    return await _categoriesRepository.deleteCategory(id);
  }
}
