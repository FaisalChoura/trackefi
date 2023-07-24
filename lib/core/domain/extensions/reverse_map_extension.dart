extension ReverseMap on List {
  Map<String, int> asReverseMap() {
    Map<String, int> map = {};
    for (var i = 0; i < length; i++) {
      map[this[i]] = i;
    }
    return map;
  }
}
