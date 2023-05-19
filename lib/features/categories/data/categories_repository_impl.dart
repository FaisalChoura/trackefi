import '../../../shared/domain/model/uncategories_row_data.dart';
import '../domain/model/category.dart';
import '../domain/repository/categories_repository.dart';
import 'categories_database.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl(this._categoriesDatabase);
  final CategoriesDatabase _categoriesDatabase;

  @override
  Future<Category?> putCategory(Category category) async {
    return await _categoriesDatabase.putCategory(category);
  }

  @override
  Future<bool> deleteCategory(int id) async {
    return await _categoriesDatabase.delete(id);
  }

  @override
  Future<Category?> getCategory(int id) async {
    return await _categoriesDatabase.get(id);
  }

  @override
  Future<List<Category>> getAllCategories() async {
    return await _categoriesDatabase.getAll();
  }

  @override
  void updateCategoriesFromRowData(List<UncategorisedRowData> values) {
    for (var data in values) {
      // create a set is used to make the list contain unique values
      data.category.keywords =
          <String>{...data.category.keywords, ...data.keywords}.toList();
      // TODO can be improved to batch operation
      putCategory(data.category);
    }
  }
}
