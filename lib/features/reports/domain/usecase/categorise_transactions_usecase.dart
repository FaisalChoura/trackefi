import 'package:expense_categoriser/core/domain/errors/exceptions.dart';
import 'package:expense_categoriser/core/domain/helpers/helpers.dart';
import 'package:expense_categoriser/features/categories/domain/repository/categories_repository.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/expense_sign.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/numbering_style.dart';
import 'package:expense_categoriser/features/reports/domain/model/report_category_snapshot.dart';

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

  Future<Map<String, ReportCategorySnapshot>> execute(
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
      double transactionAmount;
      if (row[importSettings.fieldIndexes.amountField] is double ||
          row[importSettings.fieldIndexes.amountField] is int) {
        transactionAmount = row[importSettings.fieldIndexes.amountField];
      } else {
        transactionAmount = _parseNumberStyle(importSettings.numberStyle,
            row[importSettings.fieldIndexes.amountField]);
      }

      String formatedDate = TrHelpers.formatDate(
        row[importSettings.fieldIndexes.dateField],
        importSettings.dateSeparator,
        importSettings.dateFormat,
      );
      bool isIncome = _transactionIsIncome(transactionAmount, importSettings);

      if (isIncome && transactionAmount > 0 ||
          !isIncome && transactionAmount < 0) {
        transactionAmount = transactionAmount * -1;
      }

      Transaction transaction = Transaction(
          name: row[importSettings.fieldIndexes.descriptionField],
          amount: transactionAmount,
          dateString: formatedDate,
          isIncome: isIncome,
          currencyId: importSettings.currencyId);

      Category? category =
          _findCategory(row[importSettings.fieldIndexes.descriptionField]);

      if (category != null) {
        categoriesMap[category.name]!.addTransaction(transaction);
      } else {
        categoriesMap['Uncategorised']!.addTransaction(transaction);
      }
    }

    return categoriesMap;
  }

  Category? _findCategory(String description) {
    final cleanedDescription = description.replaceAll(RegExp(r'\s\s+'), ' ');

    Category? matchedCategory;
    num lastStrength = 0;
    for (var category in _categories) {
      if (category.isPartOfCategory(cleanedDescription)) {
        num newStrength = category.matchingStrength(cleanedDescription);
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

  bool _transactionIsIncome(double amount, CsvImportSettings importSettings) {
    if (importSettings.expenseSign == ExpenseSignEnum.negative && amount > 0 ||
        importSettings.expenseSign == ExpenseSignEnum.positive && amount < 0) {
      return true;
    }
    return false;
  }
}
