import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../shared/data/database/database_model.dart';
import '../domain/model/category.dart';

class CategoriesDatabase extends DatabaseModel<Category> {
  CategoriesDatabase(super.schema);

  // Returns category or null if not found
  Future<Category?> get(int id) async {
    await checkDbConnection();

    return await isar!.categories.get(id);
  }

  // Returns category or null if not found
  Future<List<Category>> getAll() async {
    await checkDbConnection();

    return await isar!.categories.where().findAll();
  }

  Future<Category?> putCategory(Category category) async {
    await checkDbConnection();

    return await isar?.writeTxn(() async {
      await isar!.categories.put(category);
      return category;
    });
  }

  // Returns bool of status of task
  Future<bool> delete(int id) async {
    await checkDbConnection();

    return await isar!.writeTxn(() async {
      return await isar!.categories.delete(id);
    });
  }
}

final categoryRepository =
    Provider<CategoriesDatabase>((ref) => CategoriesDatabase(CategorySchema));
