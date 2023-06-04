import 'package:expense_categoriser/core/data/database/database_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repository/categories_repository.dart';
import 'categories_database.dart';
import 'categories_repository_impl.dart';

final categoriesDatabaseProvider = Provider<CategoriesDatabase>(
    (_) => CategoriesDatabase(DBManager.isntance.isar));

final categoriesRepositoryProvider = Provider<CategoriesRepository>(
    (ref) => CategoriesRepositoryImpl(ref.watch(categoriesDatabaseProvider)));
