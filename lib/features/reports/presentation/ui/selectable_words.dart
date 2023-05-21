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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var item in _getKeywordsFromString(widget.value, ' '))
              MaterialButton(
                onPressed: () => _toggleSelectedWordItem(item),
                color: selectedWordItems[item.id] != null
                    ? Colors.blue
                    : Colors.white,
                child: Text(item.keyword),
              )
          ],
        ),
      ),
    );
  }

  List<SelectableWordItem> _getKeywordsFromString(
      String value, Pattern splitBy) {
    final mappedValues = value.split(splitBy).asMap();
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
}
