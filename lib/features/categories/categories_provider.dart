import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/category_repository.dart';
import '../../utils/models/categories/category.dart';
import '../reports/ui/uncategorised_item_row.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesRepository categoriesRepository;
  CategoriesNotifier(this.categoriesRepository) : super([]) {
    _init();
  }

  _init() async {
    state = await categoriesRepository.getAll();
  }

  void addCategory(Category category) async {
    await categoriesRepository.putCategory(category);
    state = [...state, category];
  }

  void updateCategory(Category category) async {
    await categoriesRepository.putCategory(category);
    state = [
      for (final cat in state)
        if (cat.id == category.id) category else cat,
    ];
  }

  void deleteCategory(Category category) async {
    final deleted = await categoriesRepository.delete(category.id);
    if (deleted) {
      state = state.where((cat) => cat.id != category.id).toList();
    }
  }

  Future<Category?> getCategory(int id) async {
    return await categoriesRepository.get(id);
  }

  void updateCategoriesFromRowData(List<UncategorisedRowData> values) {
    for (var data in values) {
      // create a set is used to make the list contain unique values
      data.category.keywords =
          <String>{...data.category.keywords, ...data.keywords}.toList();
      // TODO can be improved to batch operation
      updateCategory(data.category);
    }
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) {
  final categoriesRepo = ref.read(categoryRepository);
  return CategoriesNotifier(categoriesRepo);
});
