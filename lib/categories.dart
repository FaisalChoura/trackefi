import "dart:convert";
import "dart:io";
import 'package:file_picker/file_picker.dart';
import "package:csv/csv.dart";

class Categoriser {
  List<Category> categories = [
    Category('Travel', ['uber', 'voi']),
    Category('Grocceries', ['lidl', 'rewe', 'rossman', 'dm']),
    Category('Restaurants', ['uber eats', 'chen che'])
  ];
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

class Category {
  String name;
  List<String> keywords;
  Category(this.name, this.keywords);
  // transactions

  bool isPartOfCategory(String description) {
    return _generateRegex().hasMatch(description.toLowerCase());
  }

  num matchingStrength(String description) {
    num strength = 0;
    String matchedKeyword = '';
    for (var keyword in keywords) {
      if (RegExp(keyword).hasMatch(description.toLowerCase())) {
        matchedKeyword = keyword;
        break; // exit of first match
      }
    }
    List<String> keywordGroup = matchedKeyword.split(' ');
    for (var subKeyword in keywordGroup) {
      // keyword separator
      strength = RegExp(subKeyword).hasMatch(description.toLowerCase())
          ? strength + 1
          : strength;
    }

    return strength;
  }

  RegExp _generateRegex() {
    String regexString = keywords.join("|");
    return RegExp(regexString);
  }
}

class Transaction {
  String name;
  String date;
  num amount;
  Transaction(this.name, this.date, this.amount);
}

class ReportCategory {
  num total = 0;
  String name;
  List<Transaction> transactions;
  ReportCategory(this.name, this.transactions) {
    for (var transaction in transactions) {
      total = double.parse((total + transaction.amount).toStringAsFixed(2));
    }
  }
}

class Report {
  num income;
  num expenses;
  List<ReportCategory> categories;
  Report(this.income, this.expenses, this.categories);
}

class CsvImportSettings {
  String fieldDelimiter = ',';
  String endOfLine = '\n';
  NumberingStyle numberStyle = NumberingStyle.eu; // field needs to be parsed
  FieldIndexes fieldIndexes = FieldIndexes();
}

class FieldIndexes {
  int dateField = 0;
  int amountField = 1;
  int descriptionField = 2;
}

enum NumberingStyle { eu, us }
