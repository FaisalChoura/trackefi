import 'package:isar/isar.dart';

import '../domain/model/category.dart';

class CategoriesDatabase {
  CategoriesDatabase(this._isar);

  final Isar _isar;

  // Returns category or null if not found
  Future<Category?> get(int id) async {
    return await _isar.categories.get(id);
  }

  // Returns category or null if not found
  Future<List<Category>> getAll() async {
    return await _isar.categories.where().findAll();
  }

  Future<Category?> putCategory(Category category) async {
    return await _isar.writeTxn(() async {
      await _isar.categories.put(category);
      return category;
    });
  }

  // Returns bool of status of task
  Future<bool> delete(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.categories.delete(id);
    });
  }
}
