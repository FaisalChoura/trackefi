import 'package:expense_categoriser/features/categories/domain/repository/categories_repository.dart';

import '../enum/numbering_style.dart';
import '../model/import_settings.dart';
import '../../../categories/domain/model/category.dart';
import '../model/transaction.dart';

class CategoriseTransactionsUseCase {
  late List<Category> _categories;
  final CategoriesRepository _categoriesRepository;

  CategoriseTransactionsUseCase(this._categoriesRepository) {
    _getCategories();
  }

  _getCategories() async {
    _categories = await _categoriesRepository.getAllCategories();
  }

  Future<Map<String, List<Transaction>>> execute(
      List<List<dynamic>> data, CsvImportSettings importSettings) async {
    // get updated list of categories
    await _getCategories();
    importSettings.fieldIndexes.amountField = 2;
    importSettings.fieldIndexes.dateField = 0;
    importSettings.fieldIndexes.descriptionField = 1;

    Map<String, List<Transaction>> categorisedTransactions =
        <String, List<Transaction>>{};

    for (var category in _categories) {
      categorisedTransactions.putIfAbsent(category.name, () => []);
    }
    categorisedTransactions.putIfAbsent('Uncategorised', () => []);

    for (var i = 1; i < data.length; i++) {
      List<dynamic> row = data[i];
      num transactionAmount = _parseNumberStyle(importSettings.numberStyle,
          row[importSettings.fieldIndexes.amountField]);
      Transaction transaction = Transaction(
          row[importSettings.fieldIndexes.descriptionField],
          row[importSettings.fieldIndexes.dateField],
          transactionAmount);

      Category? category = _findCategory(row[1]);

      if (category != null) {
        categorisedTransactions[category.name]!.add(transaction);
      } else {
        categorisedTransactions['Uncategorised']!.add(transaction);
      }
    }
    return categorisedTransactions;
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

  num _parseNumberStyle(NumberingStyle numberingStyle, String amount) {
    if (numberingStyle == NumberingStyle.eu) {
      return num.parse(
        amount.replaceAll(RegExp(','), '.'),
      );
    }
    return num.parse(amount);
  }
}
