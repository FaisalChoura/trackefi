import 'package:expense_categoriser/core/domain/errors/exceptions.dart';
import 'package:expense_categoriser/features/categories/domain/repository/categories_repository.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';

import '../enum/numbering_style.dart';
import '../../../csv_files/domain/model/import_settings.dart';
import '../../../categories/domain/model/category.dart';

class CategoriseTransactionsUseCase {
  late List<Category> _categories;
  final CategoriesRepository _categoriesRepository;

  CategoriseTransactionsUseCase(this._categoriesRepository) {
    _getCategories();
  }

  _getCategories() async {
    _categories = await _categoriesRepository.getAllCategories();
  }

  Future<List<ReportCategorySnapshot>> execute(
      List<List<dynamic>> data, CsvImportSettings importSettings) async {
    // get updated list of categories
    await _getCategories();

    Map<String, ReportCategorySnapshot> categoriesMap =
        <String, ReportCategorySnapshot>{};

    categoriesMap.putIfAbsent(
        'Uncategorised',
        () =>
            ReportCategorySnapshot.fromCategory(Category('Uncategorised', [])));
    for (var category in _categories) {
      categoriesMap.putIfAbsent(
          category.name, () => ReportCategorySnapshot.fromCategory(category));
    }

    for (var i = 1; i < data.length; i++) {
      List<dynamic> row = data[i];
      double transactionAmount = _parseNumberStyle(importSettings.numberStyle,
          row[importSettings.fieldIndexes.amountField]);

      _validateDateField(row[importSettings.fieldIndexes.dateField]);

      Transaction transaction = Transaction(
          row[importSettings.fieldIndexes.descriptionField],
          transactionAmount,
          row[importSettings.fieldIndexes.dateField]);

      Category? category =
          _findCategory(row[importSettings.fieldIndexes.descriptionField]);

      if (category != null) {
        categoriesMap[category.name]!.addTransaction(transaction);
      } else {
        categoriesMap['Uncategorised']!.addTransaction(transaction);
      }
    }
    return categoriesMap.values.toList();
  }

  Category? _findCategory(String description) {
    Category? matchedCategory;
    num lastStrength = 0;
    for (var category in _categories) {
      if (category.isPartOfCategory(description)) {
        num newStrength = category.matchingStrength(description);
        if (newStrength > lastStrength) {
          matchedCategory = category;
          lastStrength = newStrength;
        }
      }
    }
    return matchedCategory;
  }

  double _parseNumberStyle(NumberingStyle numberingStyle, String amount) {
    try {
      if (numberingStyle == NumberingStyle.eu) {
        return double.parse(
          amount.replaceAll(RegExp(','), '.'),
        );
      }
      return double.parse(amount);
    } catch (e) {
      throw IncorrectAmountMappingException();
    }
  }

  bool _validateDateField(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
