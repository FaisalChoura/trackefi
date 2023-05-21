import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement;
  String name;
  List<String> keywords;
  Category(this.name, this.keywords);
  // transactions

  bool isPartOfCategory(String description) {
    if (keywords.isEmpty) {
      return false;
    }
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

  void removeKeyword(String keyword) {
    // keywords.remove(keyword);
    // TODO fix this in the future the ability not to edit
    var tempKeywords = [...keywords];
    tempKeywords.remove(keyword);
    keywords = tempKeywords;
  }

  RegExp _generateRegex() {
    String regexString = keywords.join("|");
    return RegExp(regexString);
  }
}
