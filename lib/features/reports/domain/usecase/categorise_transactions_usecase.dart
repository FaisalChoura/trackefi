import 'package:expense_categoriser/core/domain/errors/exceptions.dart';
import 'package:expense_categoriser/features/categories/domain/repository/categories_repository.dart';
import 'package:expense_categoriser/features/reports/domain/enum/date_format.dart';
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

      String formatedDate = _formatDate(
          row[importSettings.fieldIndexes.dateField], importSettings);

      Transaction transaction = Transaction(
          row[importSettings.fieldIndexes.descriptionField],
          transactionAmount,
          formatedDate);

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

  String _formatDate(String date, CsvImportSettings settings) {
    try {
      List<String> dateChunks = date.split(settings.dateSeparator);
      String formatedDate = '';
      if (settings.dateFormat == DateFormatEnum.ddmmyyyy) {
        formatedDate = "${dateChunks[2]}-${dateChunks[1]}-${dateChunks[0]}";
      } else if (settings.dateFormat == DateFormatEnum.mmddyyyy) {
        formatedDate = "${dateChunks[2]}-${dateChunks[0]}-${dateChunks[1]}";
      } else {
        throw 'WrongDateFormat';
      }
      return formatedDate;
    } catch (e) {
      throw IncorrectDateFormatException();
    }
  }
}
