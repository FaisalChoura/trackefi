import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../utils/models/categories/category.dart';
import 'db_access_repository.dart';

class CategoriesRepository extends DbAccessRepository<Category> {
  CategoriesRepository(super.schema);

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

  // Returns the id of the created or updated category
  Future<int?> putCategory(Category category) async {
    await checkDbConnection();

    return await isar?.writeTxn(() async {
      return await isar!.categories.put(category);
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

final categoryRepository = Provider<CategoriesRepository>(
    (ref) => CategoriesRepository(CategorySchema));
