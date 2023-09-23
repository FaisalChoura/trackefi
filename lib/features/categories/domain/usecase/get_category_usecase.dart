import 'package:Trackefi/features/categories/domain/model/category.dart';
import 'package:Trackefi/features/categories/domain/repository/categories_repository.dart';

class GetCategoryUseCase {
  final CategoriesRepository _categoriesRepository;

  const GetCategoryUseCase(this._categoriesRepository);

  Future<Category?> execute(int id) async {
    return await _categoriesRepository.getCategory(id);
  }
}
