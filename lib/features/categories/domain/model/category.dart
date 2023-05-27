import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement;
  String name;
  List<String> keywords;
  ColorValues? colorValues;
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

@embedded
class ColorValues {
  int? red;
  int? blue;
  int? green;
  double? opacity;
  ColorValues({this.red, this.blue, this.green, this.opacity});
  factory ColorValues.fromColor(Color color) {
    return ColorValues(
      red: color.red,
      blue: color.blue,
      green: color.green,
      opacity: color.opacity,
    );
  }

  Color toColor() {
    return Color.fromRGBO(red ?? 0, green ?? 0, blue ?? 0, opacity ?? 1);
  }
}
