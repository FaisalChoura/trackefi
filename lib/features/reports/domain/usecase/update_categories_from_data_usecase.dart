import 'package:Trackefi/features/categories/domain/repository/categories_repository.dart';

import '../model/uncategories_row_data.dart';
import '../../../categories/domain/model/category.dart';

class UpdateCategoriesFromRowData {
  final CategoriesRepository _categoriesRepository;

  UpdateCategoriesFromRowData(this._categoriesRepository);
  Future<void> execute(List<UncategorisedRowData> values) async {
    List<Category> categories = [];
    for (var data in values) {
      // create a set is used to make the list contain unique values
      data.category.keywords =
          <String>{...data.category.keywords, ...data.keywords}.toList();

      categories.add(data.category);
    }
    // check if how this works within a loop
    for (var category in categories) {
      await _categoriesRepository.putCategory(category);
    }
  }
}
