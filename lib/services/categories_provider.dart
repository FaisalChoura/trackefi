import 'package:expense_categoriser/utils/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  Isar? _isar;
  CategoriesNotifier() : super([]) {
    _init();
  }

  _init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open(
      [CategorySchema],
      directory: dir.path,
    );

    final categories = _isar!.categories;
    state = await categories.where().findAll();
  }

  void addCategory(Category category) async {
    await _isar?.writeTxn(() async {
      await _isar!.categories.put(category);
      state = [...state, category];
    });
  }

  Future<Category?> getCategory(int id) async {
    return await _isar!.categories.get(id);
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>(
        (ref) => CategoriesNotifier());
