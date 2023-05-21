import 'package:expense_categoriser/features/categories/domain/usecase/delete_category_usecase.dart';
import 'package:expense_categoriser/features/categories/domain/usecase/get_all_categories_usecase.dart';
import 'package:expense_categoriser/features/categories/domain/usecase/get_category_usecase.dart';
import 'package:expense_categoriser/features/categories/domain/usecase/put_category_usecase.dart';
import 'package:expense_categoriser/features/categories/domain/usecase/update_categories_from_data_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_module.dart';

final getCategoriesUseCaseProvider = Provider<GetCategoryUseCase>(
    (ref) => GetCategoryUseCase(ref.watch(categoriesRepositoryProvider)));

final putCategoriesUseCaseProvider = Provider<PutCategoryUseCase>(
    (ref) => PutCategoryUseCase(ref.watch(categoriesRepositoryProvider)));

final deleteCategoriesUseCaseProvider = Provider<DeleteCategoryUseCase>(
    (ref) => DeleteCategoryUseCase(ref.watch(categoriesRepositoryProvider)));

final getAllCategoriesUseCaseProvider = Provider<GetAllCategoriesUseCase>(
    (ref) => GetAllCategoriesUseCase(ref.watch(categoriesRepositoryProvider)));

final updateCategoriesFromRowDataProvider =
    Provider<UpdateCategoriesFromRowData>(
        (ref) => UpdateCategoriesFromRowData());
