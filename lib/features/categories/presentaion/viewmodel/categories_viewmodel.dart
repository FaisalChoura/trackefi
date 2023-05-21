import 'package:expense_categoriser/features/categories/domain/domain_module.dart';
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
  );
});

class CategoriesViewModel extends StateNotifier<AsyncValue<List<Category>>> {
  final GetCategoryUseCase _getCategoryUseCase;
  final PutCategoryUseCase _putCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  CategoriesViewModel(
    this._getCategoryUseCase,
    this._deleteCategoryUseCase,
    this._putCategoryUseCase,
    this._getAllCategoriesUseCase,
  ) : super(const AsyncValue.data([])) {
    _getCategoriesList();
  }

  List<Category> get _currentStateValue {
    return state.value ?? [];
  }

  _getCategoriesList() async {
    try {
      state = const AsyncValue.loading();
      final categoriesList = await _getAllCategoriesUseCase.execute();
      state = AsyncValue.data(categoriesList);
    } on Exception catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  void addCategory(Category category) async {
    await _putCategoryUseCase.execute(category);
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
      state = AsyncValue.data(newList);
    }
  }

  Future<Category?> getCategory(int id) async {
    return await _getCategoryUseCase.execute(id);
  }
}
