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

  categorise() async {
    // group transactions by category
    // get sum of category groups
    // create report
    Map<String, List<dynamic>> categorisedTransactions =
        <String, List<dynamic>>{};

    for (var category in categories) {
      categorisedTransactions.putIfAbsent(category.name, () => []);
    }

    List<List<dynamic>> data = await readCsv();
    for (var i = 1; i < data.length; i++) {
      List<dynamic> row = data[i];
      Category? category = findCategory(row[1]);
      if (category != null) {
        categorisedTransactions[category.name]!.add(row);
      }
    }

    print(categorisedTransactions);
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
