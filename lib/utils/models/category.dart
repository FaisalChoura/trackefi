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
