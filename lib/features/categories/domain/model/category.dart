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
      final escapedKeyword = RegExp.escape(keyword);
      if (RegExp(escapedKeyword).hasMatch(description.toLowerCase())) {
        matchedKeyword = keyword;
        break; // exit of first match
      }
    }
    List<String> keywordGroup = matchedKeyword.split(' ');
    for (var subKeyword in keywordGroup) {
      // keyword separator
      final escapedSubKeyword = RegExp.escape(subKeyword);
      strength = RegExp(escapedSubKeyword).hasMatch(description.toLowerCase())
          ? strength + 1
          : strength;
    }

    return strength;
  }

  void removeKeyword(String removedKeyword) {
    keywords = keywords.where((keyword) => keyword != removedKeyword).toList();
  }

  RegExp _generateRegex() {
    String regexString =
        keywords.map((keyword) => RegExp.escape(keyword)).join("|");
    return RegExp(regexString);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'keywords': keywords,
      'colorValues': colorValues != null ? colorValues!.toJson() : null,
    };
  }

  factory Category.fromJson(Map json) {
    final keywords =
        (json['keywords'] as List).map((e) => e.toString()).toList();
    final category = Category(json['name'], keywords);
    category.id = json['id'];
    category.colorValues = json['colorValues'] != null
        ? ColorValues.fromJson(json['colorValues'])
        : null;
    return category;
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

  Map<String, num?> toJson() {
    return {
      'red': red,
      'blue': blue,
      'green': green,
      'opacity': opacity,
    };
  }

  factory ColorValues.fromJson(Map json) {
    return ColorValues(
      red: json['red'],
      blue: json['blue'],
      green: json['green'],
      opacity: json['opacity'],
    );
  }
}
