import '../../../../shared/domain/model/uncategories_row_data.dart';
import '../model/category.dart';

class UpdateCategoriesFromRowData {
  UpdateCategoriesFromRowData();
  List<Category> execute(List<UncategorisedRowData> values) {
    List<Category> categories = [];
    for (var data in values) {
      // create a set is used to make the list contain unique values
      data.category.keywords =
          <String>{...data.category.keywords, ...data.keywords}.toList();

      categories.add(data.category);
    }
    return categories;
  }
}
