import "dart:convert";
import "dart:io";
import 'package:file_picker/file_picker.dart';
import "package:csv/csv.dart";

import '../utils/enums/numbering_style.dart';
import '../utils/models/category.dart';
import '../utils/models/import_settings.dart';
import '../utils/models/report.dart';
import '../utils/models/transaction.dart';

class Categoriser {
  List<Category> categories = [];

  Categoriser(this.categories);

  Future<List<List<dynamic>>> readCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;

      final input = File(file.path!).openRead();
      return await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter(eol: "\n", fieldDelimiter: ","))
          .toList();
    }
    return [];
  }

  Future<Map<String, List<Transaction>>> categorise() async {
    CsvImportSettings importSettings = CsvImportSettings();
    importSettings.fieldIndexes.amountField = 2;
    importSettings.fieldIndexes.dateField = 0;
    importSettings.fieldIndexes.descriptionField = 1;

    Map<String, List<Transaction>> categorisedTransactions =
        <String, List<Transaction>>{};

    for (var category in categories) {
      categorisedTransactions.putIfAbsent(category.name, () => []);
    }

    List<List<dynamic>> data = await readCsv();
    for (var i = 1; i < data.length; i++) {
      List<dynamic> row = data[i];
      Category? category = findCategory(row[1]);
      if (category != null) {
        num transactionAmount = _parseNumberStyle(importSettings.numberStyle,
            row[importSettings.fieldIndexes.amountField]);
        Transaction transaction = Transaction(
            row[importSettings.fieldIndexes.descriptionField],
            row[importSettings.fieldIndexes.dateField],
            transactionAmount);
        categorisedTransactions[category.name]!.add(transaction);
      }
    }
    Report report = generateReport(categorisedTransactions);
    return categorisedTransactions;
  }

  Report generateReport(
      Map<String, List<Transaction>> categorisedTransactions) {
    Report report = Report(0, 0, []);
    for (var categoryName in categorisedTransactions.keys) {
      ReportCategory category =
          ReportCategory(categoryName, categorisedTransactions[categoryName]!);
      report.categories.add(category);
    }
    return report;
  }

  Category? findCategory(String description) {
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
