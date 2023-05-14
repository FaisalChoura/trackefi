import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/models/categories/category.dart';

class CategoriesRepository {
  CategoriesRepository();

  Isar? _isar;

  Future<void> _initDatabase() async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar ??= await Isar.open(
        [CategorySchema],
        directory: dir.path,
      );
    }
  }

  // Returns category or null if not found
  Future<Category?> get(int id) async {
    await _initDatabase();
    return await _isar!.categories.get(id);
  }

  // Returns category or null if not found
  Future<List<Category>> getAll() async {
    await _initDatabase();

    return await _isar!.categories.where().findAll();
  }

  // Returns the id of the created or updated category
  Future<int?> putCategory(Category category) async {
    await _initDatabase();

    return await _isar?.writeTxn(() async {
      return await _isar!.categories.put(category);
    });
  }

  // Returns bool of status of task
  Future<bool> delete(int id) async {
    await _initDatabase();

    return await _isar!.writeTxn(() async {
      return await _isar!.categories.delete(id);
    });
  }
}

final categoryRepository =
    Provider<CategoriesRepository>((ref) => CategoriesRepository());
