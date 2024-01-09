import 'dart:collection';

import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/core/presentation/ui/button.dart';
import 'package:flutter/material.dart';
import '../../domain/model/selectable_word_item.dart';

class SelectableWords extends StatefulWidget {
  const SelectableWords({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<List<SelectableWordItem>> onChanged;

  @override
  State<SelectableWords> createState() => _SelectableWordsState();
}

class _SelectableWordsState extends State<SelectableWords> {
  Map<int, SelectableWordItem> selectedWordItems = {};
  late List<SelectableWordItem> selectableList;

  @override
  void initState() {
    super.initState();
    selectableList = _getKeywordsFromString(widget.value, ' ');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            (selectedWordItems.length > 1)
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TrButton(
                      onPressed: () => _mergeKeywords(),
                      child: const Text('Merge'),
                    ),
                  )
                : Container(),
            for (var item in selectableList)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: MaterialButton(
                  elevation: 0,
                  hoverElevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: TColors.mainBlue),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                      bottom: Radius.circular(10),
                    ),
                  ),
                  onPressed: () => _toggleSelectedWordItem(item),
                  color: selectedWordItems[item.id] != null
                      ? TColors.mainBlue
                      : Colors.white,
                  child: Text(item.keyword),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<SelectableWordItem> _getKeywordsFromString(
      String value, Pattern splitBy) {
    final mappedValues =
        value.split(splitBy).where((word) => word.isNotEmpty).toList().asMap();
    return mappedValues.keys.map((key) {
      return SelectableWordItem(key, mappedValues[key] ?? '');
    }).toList();
  }

  void _toggleSelectedWordItem(SelectableWordItem item) {
    if (selectedWordItems[item.id] != null) {
      selectedWordItems.remove(item.id);
    } else {
      selectedWordItems[item.id] = item;
    }

    setState(() {
      selectedWordItems = selectedWordItems;

      widget.onChanged(selectedWordItems.values.toList());
    });
  }

  void _mergeKeywords() {
    final sortedMergedKeywords = SplayTreeMap<int, SelectableWordItem>.from(
        selectedWordItems, (key1, key2) {
      return key1.compareTo(key2);
    });

    final mergedKeyword = sortedMergedKeywords.values
        .map((wordItem) => wordItem.keyword)
        .join(' ');

    final firstMergedIndex = selectedWordItems.keys.toList().first;

    setState(() {
      selectableList[firstMergedIndex] =
          SelectableWordItem(firstMergedIndex, mergedKeyword);

      int removedCount = 0;
      for (var i = firstMergedIndex + 1;
          i <= selectedWordItems.keys.length - 1;
          i++) {
        final index = selectedWordItems.keys.toList()[i - removedCount];
        selectableList.removeAt(index);
        removedCount += 1;
      }
    });

    selectedWordItems.clear();
    selectedWordItems[0] = SelectableWordItem(0, mergedKeyword);
    widget.onChanged(selectedWordItems.values.toList());
  }
}
