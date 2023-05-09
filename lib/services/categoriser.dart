import 'package:expense_categoriser/services/csv_reader_service.dart';

import '../utils/enums/numbering_style.dart';
import '../utils/models/category.dart';
import '../utils/models/import_settings.dart';
import '../utils/models/transaction.dart';

class Categoriser {
  List<Category> categories;
  final CsvReaderService _csvReaderService = CsvReaderService();

  Categoriser(this.categories);

  Future<Map<String, List<Transaction>>> categorise(
      List<List<dynamic>> data) async {
    CsvImportSettings importSettings = CsvImportSettings();
    importSettings.fieldIndexes.amountField = 2;
    importSettings.fieldIndexes.dateField = 0;
    importSettings.fieldIndexes.descriptionField = 1;

    Map<String, List<Transaction>> categorisedTransactions =
        <String, List<Transaction>>{};

    for (var category in categories) {
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
    for (var category in categories) {
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
