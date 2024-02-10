import 'package:Trackefi/features/categories/domain/domain_module.dart';
import 'package:Trackefi/features/categories/domain/usecase/return_preselected_color_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/category.dart';
import '../../domain/usecase/delete_category_usecase.dart';
import '../../domain/usecase/get_all_categories_usecase.dart';
import '../../domain/usecase/get_category_usecase.dart';
import '../../domain/usecase/put_category_usecase.dart';

final categoriesViewModelStateNotifierProvider = StateNotifierProvider
    .autoDispose<CategoriesViewModel, AsyncValue<List<Category>>>((ref) {
  return CategoriesViewModel(
      ref.watch(getCategoriesUseCaseProvider),
      ref.watch(deleteCategoriesUseCaseProvider),
      ref.watch(putCategoriesUseCaseProvider),
      ref.watch(getAllCategoriesUseCaseProvider),
      ref.watch(returnPreselectedColorUseCase));
});

class CategoriesViewModel extends StateNotifier<AsyncValue<List<Category>>> {
  final GetCategoryUseCase _getCategoryUseCase;
  final PutCategoryUseCase _putCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final ReturnPreselectedColorUseCase _returnPreselectedColorUseCase;

  int _categoriesCounter = 0;

  CategoriesViewModel(
      this._getCategoryUseCase,
      this._deleteCategoryUseCase,
      this._putCategoryUseCase,
      this._getAllCategoriesUseCase,
      this._returnPreselectedColorUseCase)
      : super(const AsyncValue.data([])) {
    _getCategoriesList();
  }

  List<Category> get _currentStateValue {
    return state.value ?? [];
  }

  _getCategoriesList() async {
    try {
      state = const AsyncValue.loading();
      final categoriesList = await _getAllCategoriesUseCase.execute();
      _categoriesCounter = categoriesList.length;
      state = AsyncValue.data(categoriesList);
    } on Exception catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  void addCategory(Category category) async {
    category.colorValues =
        _returnPreselectedColorUseCase.execute(_categoriesCounter);
    await _putCategoryUseCase.execute(category);
    _categoriesCounter += 1;
    state = AsyncValue.data([..._currentStateValue, category]);
  }

  void updateCategory(Category category) async {
    await _putCategoryUseCase.execute(category);
    final newList = [
      for (final cat in _currentStateValue)
        if (cat.id == category.id) category else cat,
    ];
    state = AsyncValue.data(newList);
  }

  void deleteCategory(int id) async {
    final deleted = await _deleteCategoryUseCase.execute(id);

    if (deleted) {
      final newList = _currentStateValue.where((cat) => cat.id != id).toList();
      _categoriesCounter -= 1;
      state = AsyncValue.data(newList);
    }
  }

  Future<Category?> getCategory(int id) async {
    return await _getCategoryUseCase.execute(id);
  }
}
