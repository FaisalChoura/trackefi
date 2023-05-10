import 'package:expense_categoriser/ui/selectable_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/categories_provider.dart';
import '../utils/models/category.dart';
import '../utils/models/selectable_word_item.dart';
import '../utils/models/transaction.dart';

class UncategorisedItemRow extends ConsumerStatefulWidget {
  const UncategorisedItemRow({
    super.key,
    required this.transaction,
    required this.categories,
  });

  final Transaction transaction;
  final List<Category> categories;

  @override
  ConsumerState<UncategorisedItemRow> createState() =>
      _UncategorisedItemRowState();
}

class _UncategorisedItemRowState extends ConsumerState<UncategorisedItemRow> {
  late Category selectedCategory;
  List<SelectableWordItem> selectedWords = [];

  @override
  void initState() {
    selectedCategory = widget.categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableWords(
          value: widget.transaction.name,
          onChanged: (values) {
            setState(() {
              selectedWords = values;
            });
          },
        ),
        DropdownButton(
            value: selectedCategory!.id,
            items: widget.categories
                .map(
                  (category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ),
                )
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedCategory = widget.categories
                    .where((element) => element.id == val!)
                    .first;
              });
            }),
        Text(widget.transaction.amount.toString()),
        IconButton(
          onPressed: () {
            final addedKeywords = selectedWords
                .map((selectableWord) => selectableWord.keyword.toLowerCase())
                .toList();
            selectedCategory.keywords = [
              ...selectedCategory.keywords,
              ...addedKeywords
            ];
            ref
                .read(categoriesProvider.notifier)
                .updateCategory(selectedCategory);
          },
          icon: const Icon(Icons.check),
        )
      ],
    );
  }
}
